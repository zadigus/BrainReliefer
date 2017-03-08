#include "DataExceptions.hpp"

#include "core/Utils.hpp"

namespace N_Data {

#ifdef __ANDROID__
  //-------------------------------------------------------------------------------
  const char* XInvalidData::what() const NOEXCEPT
  {
    QFile xmlFile(m_Xml);

    if(!xmlFile.exists())
    {
      return "XML file does not exist.";
    }
    return "XML file not validated by XSD file.";
  }
#else
  //-------------------------------------------------------------------------------
  const char* XInvalidData::what() const NOEXCEPT
  {
    QFile xmlFile(m_Xml);

    if(!xmlFile.exists())
    {
      QString msg(QString::fromStdString("XML file <%1> does not exist.").arg(m_Xml));
      return N_Utils::qStringToChar(msg);
    }

    QString msg(QString::fromStdString("XML file <%1> not validated by XSD file <%2>.").arg(m_Xml).arg(m_Xsd.toString()));
    return N_Utils::qStringToChar(msg);
  }
#endif

}
