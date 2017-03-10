#include "Utils.hpp"

#include <QString>
#include <QFile>
#include <QTextStream>

namespace N_Utils {

  //-------------------------------------------------------------------------------
  const char* qStringToChar(const QString& a_Value)
  {
    char* p(new char[a_Value.length()+1]);
    strcpy(p, a_Value.toLatin1().constData());
    return p;
  }

  //-------------------------------------------------------------------------------
  void writeTextToFile(const QString& a_Filename, QIODevice::OpenModeFlag a_OpenModeFlag, const QString& a_Output)
  {
    QFile outFile(a_Filename);
    if(outFile.open(a_OpenModeFlag | QIODevice::Text))
    {
      QTextStream ts(&outFile);
      ts << a_Output << endl;
    }
    outFile.close();
  }
}
