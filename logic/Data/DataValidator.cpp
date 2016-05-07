#include "DataValidator.hpp"

#include <QtXmlPatterns>
#include <QFile>

namespace N_Data
{

  namespace N_DataValidator
  {
    //-------------------------------------------------------------------------------------------
    bool validateXMLData(const QXmlSchema& a_Schema, QFile& a_XmlFile)
    {
      a_XmlFile.open(QIODevice::ReadOnly);
      QXmlSchemaValidator validator(a_Schema);
      bool ret(validator.validate(&a_XmlFile, QUrl::fromLocalFile(a_XmlFile.fileName())));
      a_XmlFile.close();
      return ret;
    }

    //-------------------------------------------------------------------------------------------
    bool isXMLDataValid(QFile& a_XsdFile, QFile& a_XmlFile)
    {
      a_XsdFile.open(QIODevice::ReadOnly);

      QXmlSchema schema;
      schema.load(&a_XsdFile, QUrl::fromLocalFile(a_XsdFile.fileName()));

      a_XsdFile.close();

      bool ret(schema.isValid() ? validateXMLData(schema, a_XmlFile) : false);

      return ret;
    }

  }

}
