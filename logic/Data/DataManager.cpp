#include "DataManager.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataExceptions.hpp"
#include "Data/DataConstants.hpp"
//#include "Data/Data.hpp"
//#include "Data/Data-pimpl.hpp"
#include "Data/IntrantList.hpp"
#include "Data/SharedIntrant.hpp"
#include "Data/SharedAction.hpp"

#include "Models/IntrantsList.hpp"

#include <QFile>
#include <QDir>

#include <sstream>
#include <functional>

using namespace std::placeholders;

namespace N_Data {

  //----------------------------------------------------------------------------------------------
  DataManager::T_LoadSignals loadSignals(DataManager* a_DataManager)
  {
    DataManager::T_LoadSignals result;
    result.insert(NEW_INTRANTS_XML, std::bind(&DataManager::newIntrantsLoaded, a_DataManager, _1));
    result.insert(INCUBATION_XML, std::bind(&DataManager::incubatedLoaded, a_DataManager, _1));
    result.insert(REFERENCES_XML, std::bind(&DataManager::referencesLoaded, a_DataManager, _1));
    result.insert(PROJECTS_XML, std::bind(&DataManager::projectsLoaded, a_DataManager, _1));
    return result;
  }

  //----------------------------------------------------------------------------------------------
  DataManager::DataManager(QObject* a_Parent)
    : QObject(a_Parent)
    , m_LoadSignals(loadSignals(this))
  { }

  //----------------------------------------------------------------------------------------------
  DataManager::~DataManager()
  { }

  //----------------------------------------------------------------------------------------------
  void DataManager::addAction(N_Models::IntrantsList* a_SrcModel, N_Data::SharedAction* a_Action, int a_Idx)
  {
    a_SrcModel->addAction(a_Action->getData(), a_Idx);
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::addIntrant(N_Models::IntrantsList* a_SrcModel, SharedIntrant* a_Intrant)
  {
    a_SrcModel->addIntrant(a_Intrant->getData());
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::removeIntrant(N_Models::IntrantsList* a_SrcModel, int a_Idx)
  {
    a_SrcModel->removeIntrant(a_Idx);
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::transferIntrant(N_Models::IntrantsList* a_SrcModel, N_Models::IntrantsList* a_DestModel, int a_Idx)
  {
    std::unique_ptr<Intrant> intrant(a_SrcModel->popIntrant(a_Idx));
    a_DestModel->addIntrant(std::move(intrant));
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::loadExistingFiles(const QDir& a_DataDir)
  {
    QStringList filters;
    filters << "*.xml";
    foreach(auto& filename, a_DataDir.entryList(filters))
    {
      auto it(m_LoadSignals.find(filename));
      if(it != m_LoadSignals.end())
      {
        emit m_LoadSignals[filename](a_DataDir.absoluteFilePath(filename));
        m_LoadSignals.remove(filename);
      }
    }
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::createMissingFiles(const QDir& a_DataDir)
  {
    for(auto filename : m_LoadSignals.keys())
    {
      QFile file(a_DataDir.absoluteFilePath(filename));
      file.open(QIODevice::WriteOnly | QIODevice::Text);
      file.close();
    }
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::load(const QString& a_PathToDir)
  {
    QDir dataDir(a_PathToDir);

    if(!dataDir.exists() || a_PathToDir.isEmpty())
    {
      emit invalidDataFile();
      return;
    }

    loadExistingFiles(dataDir);
    createMissingFiles(dataDir);

    m_LoadSignals.clear();
  }

}
