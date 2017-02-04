#ifndef DATA_DATAMANAGERHELPER_HPP
#define DATA_DATAMANAGERHELPER_HPP

#include "core/Global.hpp"

#include "Data/DataValidator.hpp"
#include "Data/DataExceptions.hpp"

#include <QUrl>
#include <QFileInfo>

namespace N_Data {

  namespace N_DataManagerHelper {

    template <class T> std::unique_ptr<T> getParsedXML(const QString& a_XmlFilename, const QUrl& a_XsdFilename, const std::function<std::unique_ptr<T>(const std::string&)>& a_Functor)
    {
      QFile xmlFile(a_XmlFilename);
      if(!N_DataValidator::isXMLDataValid(a_XsdFilename, xmlFile))
      {
        throw XInvalidData(a_XmlFilename, a_XsdFilename);
      }

      QFileInfo info(xmlFile);
      return a_Functor(info.absoluteFilePath().toStdString());
    }

  }
}

#endif // DATA_DATAMANAGERHELPER_HPP
