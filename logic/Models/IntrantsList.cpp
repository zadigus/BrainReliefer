#include "Models/IntrantsList.hpp"

#include "Models/ModelsHelper.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataValidator.hpp"
#include "Data/DataManager.hpp"
#include "Data/DataExceptions.hpp"

#include "Data/IntrantList.hpp"

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
  void IntrantsList::setDate(int a_Idx, const QDate& a_Date)
  {
//    m_Data->Intrant().at(a_Idx).deadlineDate(Intrant::deadlineDate_type(a_Date.year(), a_Date.month(), a_Date.day()));

//    QModelIndex currentIdx(index(a_Idx, columnCount() - 1));
//    emit dataChanged(currentIdx, currentIdx);
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::save()
  {
    LOG_INF("Storing the data in the file <" << m_LoadedFilename.toStdString() << ">.");

//    xml_schema::namespace_infomap map;
//    map[""].name = "";
//    map[""].schema = "";

//    std::ofstream ofs(m_LoadedFilename.toStdString());
//    IntrantList_ (ofs, *m_Data, map);
//    ofs.close();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::addAction(const N_Data::Action& a_Action, int a_Idx)
  {
//    LOG_INF("Adding action <" << a_Action.title() << "> to intrant <" << m_Data->Intrant().at(a_Idx).title() << ">");

//    Intrant& intrant(m_Data->Intrant().at(a_Idx));

//    if(intrant.actions().present())
//    {
//      qDebug() << "Actions present";
//      ActionList& actionList(*(intrant.actions()));
//      actionList.Action().push_back(a_Action);
//    }
//    else
//    {
//      qDebug() << "Actions not present";
//      ActionList actionList;
//      actionList.Action().push_back(a_Action);
//      intrant.actions().set(actionList);
//    }

//    QModelIndex currentIdx(index(a_Idx, columnCount() - 1));
//    emit dataChanged(currentIdx, currentIdx);

//    // TODO: only save if you are in the project model; in the newIntrantsModel, this shouldn't be saved
//    save();
  }

  //-------------------------------------------------------------------------------------------
  std::unique_ptr<Intrant> IntrantsList::popIntrant(int a_Idx)
  {
//    std::unique_ptr<Intrant> result(new Intrant(m_Data->Intrant().at(a_Idx)));
//    LOG_INF("Popping out intrant with title <" << result->title() << ">");
//    removeIntrant(a_Idx);
//    return result;
      return std::unique_ptr<Intrant>();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::addIntrant(const Intrant& a_Intrant)
  {
//    LOG_INF("Adding new intrant with title <" << a_Intrant.title() << ">.");
//    int idx(static_cast<int>(m_Data->Intrant().size()));
//    beginInsertRows(QModelIndex(), idx, idx);
//    m_Data->Intrant().push_back(a_Intrant);
//    endInsertRows();
//    save();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::removeIntrant(int a_Idx)
  {
//    LOG_INF("Deleting intrant with title <" << m_Data->Intrant().at(a_Idx).title() << ">...");
//    removeRow(a_Idx);
//    save();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::loadDataFromFile(const QString& a_FileName)
  {
//    beginResetModel();

//    try
//    {
//      auto DataBuilder = [] (const std::string& a_FileName) { return IntrantList_(a_FileName, xml_schema::flags::dont_validate); };
//      m_Data = N_DataManagerHelper::getParsedXML<IntrantList>(a_FileName, m_IntrantListXsd, DataBuilder);
//    }
//    catch(const XInexistentData& ex)
//    {
//      LOG_ERR("Caught exception: " << ex.what());
//    }
//    catch(const XInvalidData& ex)
//    {
//      LOG_ERR("Caught exception: " << ex.what());
//      throw ex;
//      // TODO: if the data does not exist, then automatically create the missing file in the same directory as the main Data.xml
//    }
//    // TODO: what happens if a_FileName is empty???? --> set default filename
//    m_LoadedFilename = a_FileName;

//    endResetModel();
  }

  //-------------------------------------------------------------------------------------------
  bool IntrantsList::removeRows(int a_Row, int a_Count, const QModelIndex& /*a_Parent*/)
  {
//    int lowerIdx(a_Row);
//    int upperIdx(a_Row + a_Count - 1);

//    beginRemoveRows(QModelIndex(), lowerIdx, upperIdx);

//    m_Data->Intrant().erase(m_Data->Intrant().begin() + lowerIdx, m_Data->Intrant().begin() + upperIdx + 1);

//    endRemoveRows();
    return true;
  }

  //-------------------------------------------------------------------------------------------
  int IntrantsList::rowCount(const QModelIndex& /*parent*/) const
  {
//    if(m_Data)
//    {
//      return static_cast<int>(m_Data->Intrant().size());
//    }

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
//    switch(a_Role)
//    {
//      case TitleRole:
//        return QString::fromStdString(m_Data->Intrant().at(a_Index.row()).title());
//      case DescriptionRole:
//      {
//        Intrant::description_optional descr(m_Data->Intrant().at(a_Index.row()).description());
//        return descr.present() ? QString::fromStdString(*descr) : QString();
//      }
//      case DeadlineRole:
//      {
//        Intrant::deadlineDate_optional value(m_Data->Intrant().at(a_Index.row()).deadlineDate());
//        return value.present() ? QDate((*value).year(), (*value).month(), (*value).day()) : QDate();
//      }
//      default:
//        break;
//    }
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
    result[DeadlineRole] = "deadline";
    return result;
  }

}
