#ifndef MODELS_MODELSHELPER_HPP
#define MODELS_MODELSHELPER_HPP

#include "core/Global.hpp"

#include <QModelIndex>

class QFile;

namespace N_Models {

  namespace N_ModelsHelper {

    /*
     * Returns the absolute path to the XmlFile
     */
    std::string pathToData(const QFile& a_XmlFile);

    QModelIndex invalidIndex();
  }

}

#endif // MODELS_MODELSHELPER_HPP
