#include "DataExceptions.hpp"

#include <QFileInfo>
#include <QDebug>

namespace N_Data {

  //-------------------------------------------------------------------------------
  const char* XInvalidData::what() const noexcept
  {
    QFile xmlFile(m_Xml);
    if(!xmlFile.exists())
    {
      return "XML file does not exist.";
    }

    return "XML not validated by XSD file.";
  }

}
