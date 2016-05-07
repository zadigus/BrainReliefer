#include "ModelsHelper.hpp"

#include <QFileInfo>

namespace N_Models {

  namespace N_ModelsHelper {

    //-------------------------------------------------------------------------------------------
    std::string pathToData(const QFile& a_XmlFile)
    {
      return QFileInfo(a_XmlFile).absoluteFilePath().toStdString();
    }

  }


}
