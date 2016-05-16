#ifndef DATA_DATAMANAGERHELPER_HPP
#define DATA_DATAMANAGERHELPER_HPP

#include "Data/DataValidator.hpp"

#include <QUrl>
#include <QFileInfo>

#include <functional>
#include <memory>
#include <stdexcept>

namespace N_Data {

  namespace N_DataManagerHelper {

    template <class T> std::unique_ptr<T> getParsedXML(QFile& a_Xml, const QUrl& a_Xsd, const std::function<std::unique_ptr<T>(const std::string&)>& a_Functor)
    {
      if(!N_DataValidator::isXMLDataValid(a_Xsd, a_Xml))
      {
        throw std::runtime_error("Invalid XML file"); // TODO: throw a custom exception that inherits this one and can give back the name of the Xml and Xsd files used to validate the data
      }

      QFileInfo info(a_Xml);
      return (a_Functor(info.absoluteFilePath().toStdString()));
    }

  }
}

#endif // DATA_DATAMANAGERHELPER_HPP
