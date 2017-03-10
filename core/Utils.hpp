#ifndef UTILS_HPP
#define UTILS_HPP

#include <QIODevice>

class QString;

namespace N_Utils {

  const char* qStringToChar(const QString& a_Value);

  void writeTextToFile(const QString& a_Filename, QIODevice::OpenModeFlag a_OpenModeFlag, const QString& a_Output);

}

#endif // UTILS_HPP
