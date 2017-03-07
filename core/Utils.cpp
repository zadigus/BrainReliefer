#include "Utils.hpp"

#include <QString>

namespace N_Utils {

  //-------------------------------------------------------------------------------
  const char* qStringToChar(const QString& a_Value)
  {
    char* p(new char[a_Value.length()+1]);
    strcpy(p, a_Value.toLatin1().constData());
    return p;
  }

}
