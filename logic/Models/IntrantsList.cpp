#include "Models/IntrantsList.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataValidator.hpp"
#include "Data/DataManager.hpp"
#include "Data/DataExceptions.hpp"

#include "Data/SharedIntrant.hpp"
#include "Data/IntrantList.hpp"

#include <QDebug>
#include <QFile>
#include <QDate>

#include <fstream>

using namespace N_Data;

namespace N_Models {

  //-------------------------------------------------------------------------------------------
  IntrantsList::IntrantsList(QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_IntrantListXsd(QStringLiteral("qrc:/xsd/IntrantList.xsd"))
  { }

  //-------------------------------------------------------------------------------------------
  IntrantsList::~IntrantsList()
  { }

  //-------------------------------------------------------------------------------------------
  int IntrantsList::getNbrOfIntrants() const
  {
    return m_Data->Intrant().size();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::setDate(int a_Idx, const QDate& a_Date)
  {
    m_Data->Intrant().at(a_Idx).deadlineDate(Intrant::deadlineDate_type(a_Date.year(), a_Date.month(), a_Date.day()));
//    serialize([this, &a_Date, &a_Idx]() // TODO: why doesn't this work???? It actually works, but then the DataManager is not available any more
//                { m_Data->Intrant().at(a_Idx).deadlineDate(Intrant::deadlineDate_type(a_Date.year(), a_Date.month(), a_Date.day())); });
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
  std::unique_ptr<Intrant> IntrantsList::popIntrant(int a_Idx)
  {
    std::unique_ptr<Intrant> result(new Intrant(m_Data->Intrant().at(a_Idx)));
    LOG_INF("Popping out intrant with title <" << result->title() << ">");
    removeIntrant(a_Idx);
    return result;
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::addIntrant(const Intrant& a_Intrant)
  {
    LOG_INF("Adding new intrant with title <" << a_Intrant.title() << ">.");
    serialize([this, &a_Intrant](){ m_Data->Intrant().push_back(a_Intrant); });
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
      m_Data.reset(new IntrantList);
    }
    catch(const XInvalidData& ex)
    {
      LOG_ERR("Caught exception: " << ex.what());
      m_Data.reset(new IntrantList);
      throw ex;
      // TODO: if the data does not exist, then automatically create the missing file in the same directory as the main Data.xml
    }
    // TODO: what happens if a_FileName is empty???? --> set default filename
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

    if(m_Data->Intrant().size() > 0)
    {
      beginInsertRows(parentIndex, 0, static_cast<int>(m_Data->Intrant().size()) - 1);
      endInsertRows();

      emit dataChanged(topLeft, bottomRight);
      endResetModel();
    }
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
