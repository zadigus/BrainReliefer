#include "Models/IntrantsList.hpp"

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
  IntrantsList::IntrantsList(QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_IntrantListXsd(QStringLiteral("qrc:/xsd/IntrantList.xsd"))
  {

  }

  //-------------------------------------------------------------------------------------------
  IntrantsList::~IntrantsList()
  {

  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::store(const IntrantList& a_List)
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
  void IntrantsList::serialize(const std::function<void(void)>& a_CmdToBeSerialized)
  {
    LOG_INF("Serializing into file <" << m_LoadedFilename.toStdString() << "> following the XSD scheme <" << m_IntrantListXsd.toString().toStdString() << ">.");

    auto dataCpy(*m_Data); // keep the original data just in case we have a problem serializing the data
    a_CmdToBeSerialized();

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

  //-------------------------------------------------------------------------------------------
  void IntrantsList::addIntrant(QObject* a_Intrant)
  {
    if(QIntrant* intrant = qobject_cast<QIntrant*>(a_Intrant))
    {
      N_Data::Intrant data(intrant->getIntrant());
      LOG_INF("Adding new intrant with title <" << data.title() << ">.");
      serialize([this, &data](){ m_Data->Intrant().push_back(data); });
    }
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::removeIntrant(int a_Idx)
  {
    LOG_INF("Deleting intrant with title <" << m_Data->Intrant().at(a_Idx).title() << ">...");
    serialize([this, &a_Idx](){ m_Data->Intrant().erase(m_Data->Intrant().begin() + a_Idx); });
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::loadData (const QString& a_FileName)
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
  void IntrantsList::reload()
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
  void IntrantsList::reload(const QString& a_FileName)
  {
    loadData(a_FileName);
    reload();
  }

  //-------------------------------------------------------------------------------------------
  int IntrantsList::rowCount(const QModelIndex& /*parent*/) const
  {
    if(m_Data)
    {
      return static_cast<int>(m_Data->Intrant().size());
    }

    return 0;
  }

  //-------------------------------------------------------------------------------------------
  int IntrantsList::columnCount(const QModelIndex& /*parent*/) const
  {
    return 1;
  }

  //-------------------------------------------------------------------------------------------
  QVariant IntrantsList::data(const QModelIndex& a_Index, int a_Role) const
  {
    switch(a_Role)
    {
      case TitleRole:
        return QString::fromStdString(m_Data->Intrant().at(a_Index.row()).title());
      case DescriptionRole:
      {
        Intrant::description_optional descr(m_Data->Intrant().at(a_Index.row()).description());
        return descr.present() ? QString::fromStdString(*descr) : QString();
      }
      default:
        break;
    }
    return QVariant();
  }

  //-------------------------------------------------------------------------------------------
  QVariant IntrantsList::headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role) const
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
  QHash<int, QByteArray> IntrantsList::roleNames() const
  {
    QHash<int, QByteArray> result;
    result[TitleRole] = "title";
    result[DescriptionRole] = "description";
    return result;
  }

}
