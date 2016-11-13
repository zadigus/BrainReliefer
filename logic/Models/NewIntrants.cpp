#include "Models/NewIntrants.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataValidator.hpp"
#include "Data/DataManager.hpp"
#include "Data/DataExceptions.hpp"

#include "Data/QIntrant.hpp"
#include "Data/IntrantList.hpp"

#include <QDebug>
#include <QFile>

#include <fstream>

using namespace N_Data;

namespace N_Models {

  //-------------------------------------------------------------------------------------------
  NewIntrants::NewIntrants(QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_IntrantListXsd(QStringLiteral("qrc:/xsd/IntrantList.xsd"))
  {

  }

  //-------------------------------------------------------------------------------------------
  NewIntrants::~NewIntrants()
  {

  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::store(const IntrantList& a_List)
  {
    LOG_INF("Storing the data in the file <" << m_LoadedFilename.toStdString() << ">.");

    xml_schema::namespace_infomap map;
    map[""].name = "";
    map[""].schema = "";

    std::ofstream ofs(m_LoadedFilename.toStdString());
    IntrantList_ (ofs, a_List, map);
    ofs.close();
  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::addIntrant(QObject* a_Intrant)
  {
    if(QIntrant* intrant = qobject_cast<QIntrant*>(a_Intrant))
    {
      N_Data::Intrant data(intrant->getIntrant());
      LOG_INF("Adding new intrant with title <" << data.title() << ">.");

      // TODO: be careful with the unique ID:
      // - get highest id from the list (or store it during loading and then update the value)
      // - set a higher id to the item we are adding to the list
      // - the DataManager must be responsible for the uniqueID's incrementation
      auto dataCpy(*m_Data); // keep the original data just in case we have a problem serializing the data
      m_Data->Intrant().push_back(data);

      LOG_INF("Serializing into file <" << m_LoadedFilename.toStdString() << "> following the XSD scheme <" << m_IntrantListXsd.toString().toStdString() << ">.");

      try
      {
        store(*m_Data);
        reload(m_LoadedFilename);
      }
      catch(const XInvalidData& ex)
      {
        LOG_ERR("Serialization failed. Restoring the data to their original state (" << ex.what() << ").");
        store(dataCpy);
        reload(m_LoadedFilename);
      }
    }
  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::loadData (const QString& a_FileName)
  {
    try
    {
      auto DataBuilder = [] (const std::string& a_FileName) { return IntrantList_(a_FileName, xml_schema::flags::dont_validate); };
      m_Data = N_DataManagerHelper::getParsedXML<IntrantList>(a_FileName, m_IntrantListXsd, DataBuilder);
    }
    catch(const XInexistentData& ex)
    {
      LOG_ERR("Caught exception: " << ex.what());
      m_Data.reset();
    }
    catch(const XInvalidData& ex)
    {
      LOG_ERR("Caught exception: " << ex.what());
      m_Data.reset();
      throw ex;
      // TODO: if the data does not exist, then automatically create the missing file in the same directory as the main Data.xml
    }
    m_LoadedFilename = a_FileName;
  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::reload()
  {
    beginResetModel();

    QModelIndex parentIndex = QModelIndex();
    QModelIndex topLeft     = index(0, 0, parentIndex);
    QModelIndex bottomRight = index(rowCount(parentIndex) - 1,
                                    columnCount(parentIndex) - 1, parentIndex);

    beginInsertRows(parentIndex, 0, static_cast<int>(m_Data->Intrant().size()) - 1);
    endInsertRows();

    emit dataChanged(topLeft, bottomRight);
    endResetModel();
  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::reload(const QString& a_FileName)
  {
    loadData(a_FileName);
    reload();
  }

  //-------------------------------------------------------------------------------------------
  int NewIntrants::rowCount(const QModelIndex& /*parent*/) const
  {
    if(m_Data)
    {
      return static_cast<int>(m_Data->Intrant().size());
    }

    return 0;
  }

  //-------------------------------------------------------------------------------------------
  int NewIntrants::columnCount(const QModelIndex& /*parent*/) const
  {
    return 1;
  }

  //-------------------------------------------------------------------------------------------
  QVariant NewIntrants::data(const QModelIndex& a_Index, int a_Role) const
  {
    if(a_Role == TitleRole)
    {
      return QString::fromStdString(m_Data->Intrant().at(a_Index.row()).title());
    }
    return QVariant();
  }

  //-------------------------------------------------------------------------------------------
  QVariant NewIntrants::headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role) const
  {
    if(a_Role != TitleRole)
    {
      return QVariant();
    }

    if(a_Orientation == Qt::Horizontal)
    {
      if(a_Section == 0)
      {
        return tr("Title");
      }
    }

    return QVariant();
  }

  //-------------------------------------------------------------------------------------------
  QHash<int, QByteArray> NewIntrants::roleNames() const
  {
    QHash<int, QByteArray> result;
    result[TitleRole] = "title";
    return result;
  }

}
