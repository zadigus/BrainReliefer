#ifndef DATA_DATAVALIDATOR_HPP
#define DATA_DATAVALIDATOR_HPP

class QFile;
class QXmlSchema;
class QUrl;

namespace N_Data
{

  namespace N_DataValidator
  {

    bool validateXMLData(const QXmlSchema& a_Schema, QFile& a_XmlFile);
    bool isXMLDataValid(QFile& a_XsdFile, QFile& a_XmlFile);
    bool isXMLDataValid(const QUrl& a_XsdFile, QFile& a_XmlFile);

  }

}

#endif // DATA_DATAVALIDATOR_HPP
