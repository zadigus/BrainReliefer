#include "Models/ActionsList.hpp"

#include "Models/ModelsHelper.hpp"

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
  ActionsList::ActionsList(QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_IntrantListXsd(QStringLiteral("qrc:/xsd/IntrantList.xsd"))
  { }

  //-------------------------------------------------------------------------------------------
  ActionsList::~ActionsList()
  { }

//  //-------------------------------------------------------------------------------------------
//  void ActionsList::save()
//  {
//  }

//  //-------------------------------------------------------------------------------------------
//  void ActionsList::addActions(const std::vector<Action>& a_Actions)
//  {
//    LOG_INF("Not implemented yet");
//  }

//  //-------------------------------------------------------------------------------------------
//  void ActionsList::addAction(const Action& a_Action)
//  {
//    LOG_INF("Not implemented yet");
//  }

//  //-------------------------------------------------------------------------------------------
//  void ActionsList::removeAction(int a_Idx)
//  {
//    LOG_INF("Not implemented yet");
//  }

  //-------------------------------------------------------------------------------------------
  void ActionsList::loadDataFromFile(const QString& a_FileName)
  {
    LOG_INF("Not implemented yet");
    /*try
    {
      auto DataBuilder = [] (const std::string& a_FileName) { return IntrantList_(a_FileName, xml_schema::flags::dont_validate); };
      m_Data = N_DataManagerHelper::getParsedXML<IntrantList>(a_FileName, m_IntrantListXsd, DataBuilder);
    }
    catch(const XInexistentData& ex)
    {
      LOG_ERR("Caught exception: " << ex.what());
    }
    catch(const XInvalidData& ex)
    {
      LOG_ERR("Caught exception: " << ex.what());
      throw ex;
      // TODO: if the data does not exist, then automatically create the missing file in the same directory as the main Data.xml
    }
    // TODO: what happens if a_FileName is empty???? --> set default filename
    m_LoadedFilename = a_FileName;

    auto size(static_cast<int>(m_Data->Intrant().size()));
    beginResetModel();
    if(size > 0)
    {
      beginInsertRows(N_ModelsHelper::invalidIndex(), 0, size - 1);
      endInsertRows();
    }
    endResetModel();*/
  }

  //-------------------------------------------------------------------------------------------
  bool ActionsList::removeRows(int a_Row, int a_Count, const QModelIndex& /*a_Parent*/)
  {
    int lowerIdx(a_Row);
    int upperIdx(a_Row + a_Count - 1);

    beginRemoveRows(QModelIndex(), lowerIdx, upperIdx);

//    m_Data->Intrant().erase(m_Data->Intrant().begin() + lowerIdx, m_Data->Intrant().begin() + upperIdx + 1);
    LOG_INF("Not implemented yet");

    endRemoveRows();
    return true;
  }

  //-------------------------------------------------------------------------------------------
  int ActionsList::rowCount(const QModelIndex& /*parent*/) const
  {
//    if(m_Data)
//    {
//      return static_cast<int>(m_Data->Intrant().size());
//    }

    return 0;
  }

  //-------------------------------------------------------------------------------------------
  int ActionsList::columnCount(const QModelIndex& /*parent*/) const
  {
    return 1;
  }

  //-------------------------------------------------------------------------------------------
  QVariant ActionsList::data(const QModelIndex& a_Index, int a_Role) const
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
  QVariant ActionsList::headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role) const
  {
    if(a_Role != TitleRole)
    {
      return QVariant();
    }

//    if(a_Orientation == Qt::Horizontal)
//    {
//      if(a_Section == 0)
//      {
//        return tr("Title");
//      }
//    }

    return QVariant();
  }

  //-------------------------------------------------------------------------------------------
  QHash<int, QByteArray> ActionsList::roleNames() const
  {
    QHash<int, QByteArray> result;
    result[TitleRole] = "title";
    result[DelegateRole] = "delegate";
    result[DeadlineRole] = "deadline";
    return result;
  }

}
