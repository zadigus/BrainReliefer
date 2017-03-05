#ifndef DATA_DATAMANAGERHELPER_HPP
#define DATA_DATAMANAGERHELPER_HPP

#include "core/Global.hpp"

#include "Data/DataValidator.hpp"
#include "Data/DataExceptions.hpp"

#include <xsde/cxx/parser/expat/document.hxx>

#include <QUrl>
#include <QFileInfo>

namespace N_Data {

  namespace N_DataManagerHelper {

    template <class T>
    std::unique_ptr<T> getParsedXML(const QString& a_XmlFilename, const QUrl& a_XsdFilename, const std::function<std::unique_ptr<T>(const std::string&)>& a_Functor);

    template<class Data_paggr, class Data>
    std::unique_ptr<Data> parse(const std::string& a_Filename);

    //--------------------------------------------------------------------------------------------------------------------------------------------------------------
    // inline / template method(s) implementation
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------

    //--------------------------------------------------------------------------------------------------------------------------------------------------------------
    template <class T>
    std::unique_ptr<T> getParsedXML(const QString& a_XmlFilename, const QUrl& a_XsdFilename, const std::function<std::unique_ptr<T>(const std::string&)>& a_Functor)
    {
      QFile xmlFile(a_XmlFilename);
      if(!N_DataValidator::isXMLDataValid(a_XsdFilename, xmlFile))
      {
        throw XInvalidData(a_XmlFilename, a_XsdFilename);
      }

      QFileInfo info(xmlFile);
      return a_Functor(info.absoluteFilePath().toStdString());
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

  }
}

#endif // DATA_DATAMANAGERHELPER_HPP
