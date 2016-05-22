#include "DataExceptions.hpp"

#include <QFileInfo>
#include <QDebug>

namespace N_Data {

  //-------------------------------------------------------------------------------
  const char* XInvalidData::what() const
  {
    if(!m_Xml.exists())
    {
      return "XML file does not exist.";
    }

    return "XML not validated by XSD file.";
  }

}
