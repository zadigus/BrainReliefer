#ifndef DATA_DATAMANAGERHELPER_HPP
#define DATA_DATAMANAGERHELPER_HPP

#include "core/Global.hpp"

#include "Data/DataValidator.hpp"
#include "Data/DataExceptions.hpp"

#include "core/Utils.hpp"

#include <xsde/cxx/parser/expat/document.hxx>
#include <xsde/cxx/serializer/genx/document.hxx>

#include <QUrl>
#include <QFileInfo>

#include <sstream>

namespace N_Data {

  namespace N_XsdeHelpers {

    template <class Data_paggr, class Data>
    std::unique_ptr<Data> getParsedXML(const QString& a_XmlFilename, const QUrl& a_XsdFilename);

    template<class Data_paggr, class Data>
    std::unique_ptr<Data> parse(const std::string& a_Filename);

    template<class Data_saggr, class Data>
    void serialize(const std::string& a_Filename, const Data& a_Data);

    //--------------------------------------------------------------------------------------------------------------------------------------------------------------
    // inline / template method(s) implementation
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------

    //--------------------------------------------------------------------------------------------------------------------------------------------------------------
    template <class Data_paggr, class Data>
    std::unique_ptr<Data> getParsedXML(const QString& a_XmlFilename, const QUrl& a_XsdFilename)
    {
      QFile xmlFile(a_XmlFilename);
      if(!N_DataValidator::isXMLDataValid(a_XsdFilename, xmlFile))
      {
        throw XInvalidData(a_XmlFilename, a_XsdFilename);
      }

      QFileInfo info(xmlFile);
      return parse<Data_paggr, Data>(info.absoluteFilePath().toStdString());
    }

    //--------------------------------------------------------------------------------------------------------------------------------------------------------------
    template<class Data_paggr, class Data>
    std::unique_ptr<Data> parse(const std::string& a_Filename)
    {
      Data_paggr data_p;
      xsde::cxx::parser::expat::document_pimpl doc_p(data_p.root_parser(), data_p.root_name());
      data_p.pre();
      doc_p.parse(a_Filename);
      // validation is enabled / disabled during xsd/e library compilation and xsd/e class generation but not here in the code
      return std::unique_ptr<Data>(data_p.post());
    }

    //--------------------------------------------------------------------------------------------------------------------------------------------------------------
    template<class Data_saggr, class Data>
    void serialize(const std::string& a_Filename, const Data& a_Data)
    {
      Data_saggr data_s;
      xsde::cxx::serializer::genx::document_simpl doc_s(data_s.root_serializer(), data_s.root_name());
      data_s.pre(a_Data);
      std::ostringstream ost;
      doc_s.serialize(ost, xsde::cxx::serializer::genx::document_simpl::pretty_print);
      data_s.post();

      N_Utils::writeTextToFile(QString::fromStdString(a_Filename), QIODevice::WriteOnly, QString::fromStdString(ost.str()));
    }
  }
}

#endif // DATA_DATAMANAGERHELPER_HPP
