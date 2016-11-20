#include "DataManager.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataExceptions.hpp"
#include "Data/DataConstants.hpp"
#include "Data/Data.hpp"
#include "Data/IntrantList.hpp"
#include "Data/SharedIntrant.hpp"
#include "Data/SharedAction.hpp"

#include "Models/IntrantsList.hpp"

#include <iostream>

#include <QFile>
#include <QDir>

namespace N_Data {

  //----------------------------------------------------------------------------------------------
  DataManager::DataManager(QObject* a_Parent)
    : QObject(a_Parent)
    , m_DataXsd(QStringLiteral("qrc:/xsd/Data.xsd"))
  { }

  //----------------------------------------------------------------------------------------------
  DataManager::~DataManager()
  { }

  //----------------------------------------------------------------------------------------------
  void DataManager::addAction(N_Models::IntrantsList* a_SrcModel, N_Data::SharedAction* a_Action, int a_Idx)
  {
    a_SrcModel->addAction(a_Action->getAction(), a_Idx);
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::addIntrant(N_Models::IntrantsList* a_SrcModel, SharedIntrant* a_Intrant)
  {
    a_SrcModel->addIntrant(a_Intrant->getIntrant());
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
    a_DestModel->addIntrant(*intrant);
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::load(const QUrl& a_PathToFile)
  {
    try
    {
      auto DataBuilder = [] (const std::string& a_FileName) { return Data_(a_FileName, xml_schema::flags::dont_validate); };
      m_Data = N_DataManagerHelper::getParsedXML<Data>(a_PathToFile.toLocalFile(), m_DataXsd, DataBuilder);
      emitLoaded(NEW_INTRANTS_ITEMS, std::bind(&DataManager::newIntrantsLoaded, this, std::placeholders::_1));
      emitLoaded(REFERENCE_ITEMS, std::bind(&DataManager::referencesLoaded, this, std::placeholders::_1));
      emitLoaded(INCUBATION_ITEMS, std::bind(&DataManager::incubatedLoaded, this, std::placeholders::_1));
    }
    catch(const XInvalidData& ex)
    {
      LOG_WRN("Caught XInvalidData exception: " << ex.what());
      emit invalidDataFile();
    }
    catch(const XInexistentData& ex)
    {
      LOG_ERR("Caught XInexistentData exception: " << ex.what());
      LOG_ERR("This exception is not handled yet; we should create a new empty file in this case, shouldn't we?");
      // TODO: handle this exception
    }
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::emitLoaded(const std::string& a_ItemName, const std::function<void(const QString&)>& a_EmitCallback)
  {
    if(m_Data)
    {
      auto IsDataWithName = [&a_ItemName] (const DataPath& a_DataPath) { return a_DataPath.name() == a_ItemName; };
      Data::DataPath_const_iterator it(std::find_if(m_Data->DataPath().begin(), m_Data->DataPath().end(), IsDataWithName));
      if(it != m_Data->DataPath().end())
      {
        emit a_EmitCallback(QDir(QString::fromStdString(m_Data->RootDir())).filePath(QString::fromStdString(*it)));
        return;
      }
      std::stringstream ss;
      ss << a_ItemName;
      ss << " do not exist.";
      throw XInexistentData(ss.str());
      // TODO : create the file
    }
    throw XInexistentData("Main data file missing.");
  }

}
