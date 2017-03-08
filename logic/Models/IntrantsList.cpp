#include "Models/IntrantsList.hpp"

#include "Models/ModelsHelper.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataValidator.hpp"
#include "Data/DataManager.hpp"
#include "Data/DataExceptions.hpp"

#include "Data/IntrantList.hpp"
#include "Data/IntrantList-pimpl.hpp"

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
    auto& intrant(m_Data->Intrant()[a_Idx]);
    intrant.deadlineDate(xml_schema::date(a_Date.year(), a_Date.month(), a_Date.day()));

    QModelIndex currentIdx(index(a_Idx, columnCount() - 1));
    emit dataChanged(currentIdx, currentIdx);
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::save()
  {
    qInfo() << "Storing the data in the file <" << m_LoadedFilename << ">.";

    qWarning() << "Not implemented yet.";

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
    qInfo() << "Adding action <" << QString::fromStdString(a_Action.title()) << "> to intrant <" << QString::fromStdString(m_Data->Intrant()[a_Idx].title()) << ">";

    auto& intrant(m_Data->Intrant()[a_Idx]);

    if(intrant.actions_present())
    {
      qDebug() << "Actions present";
      auto& actionList(intrant.actions());
      actionList.Action().push_back(a_Action);
    }
    else
    {
      qDebug() << "Actions not present";
      std::unique_ptr<ActionList> actionList;
      actionList->Action().push_back(a_Action);
      intrant.actions(actionList.release());
    }

    QModelIndex currentIdx(index(a_Idx, columnCount() - 1));
    emit dataChanged(currentIdx, currentIdx);

    // TODO: only save if you are in the project model; in the newIntrantsModel, this shouldn't be saved
    save();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::removeIntrant(int a_Idx)
  {
    qInfo() << "Deleting intrant with title <" << QString::fromStdString(m_Data->Intrant()[a_Idx].title()) << ">...";
    removeRow(a_Idx);
    save();
  }

  //-------------------------------------------------------------------------------------------
  std::unique_ptr<Intrant> IntrantsList::popIntrant(int a_Idx)
  {
    auto& seq(m_Data->Intrant());
    auto it(seq.begin() + a_Idx);
    std::unique_ptr<Intrant> result(seq.detach(it)); // sets the array element a_Idx to NULL
    qInfo() << "Popping out intrant with title <" << QString::fromStdString(result->title()) << ">";
    removeIntrant(a_Idx); // removes the element a_Idx from the array
    return result;
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::addIntrant(std::unique_ptr<N_Data::Intrant> a_Intrant)
  {
    qInfo() << "Adding new intrant with title <" << QString::fromStdString(a_Intrant->title()) << ">.";
    int idx(static_cast<int>(m_Data->Intrant().size()));
    beginInsertRows(QModelIndex(), idx, idx);
    m_Data->Intrant().push_back(a_Intrant.release());
    endInsertRows();
    save();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsList::loadDataFromFile(const QString& a_FileName)
  {
    qDebug() << "Loading file " << a_FileName;

    beginResetModel();

    try
    {
      m_Data = N_DataManagerHelper::getParsedXML<N_Data::IntrantList_paggr, N_Data::IntrantList>(a_FileName, m_IntrantListXsd);
    }
    catch(const XInexistentData& ex)
    {
      qCritical() << "Caught exception: " << ex.what();
    }
    catch(const XInvalidData& ex)
    {
      qCritical() << "Caught exception: " << ex.what();
      throw ex;
      // TODO: if the data does not exist, then automatically create the missing file in the same directory as the main Data.xml
    }
    // TODO: what happens if a_FileName is empty???? --> set default filename
    m_LoadedFilename = a_FileName;

    endResetModel();
  }

  //-------------------------------------------------------------------------------------------
  bool IntrantsList::removeRows(int a_Row, int a_Count, const QModelIndex& /*a_Parent*/)
  {
    int lowerIdx(a_Row);
    int upperIdx(a_Row + a_Count - 1);

    beginRemoveRows(QModelIndex(), lowerIdx, upperIdx);
    for(int idx(upperIdx); idx >= lowerIdx; --idx)
    {
      m_Data->Intrant().erase(m_Data->Intrant().begin() + idx);
    }
    endRemoveRows();

    return true;
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
    auto& intrant(m_Data->Intrant()[a_Index.row()]);
    switch(a_Role)
    {
      case TitleRole:
        return QString::fromStdString(intrant.title());
      case DescriptionRole:
      {
        return intrant.description_present() ? QString::fromStdString(intrant.description()) : QString();
      }
      case DeadlineRole:
      {
        return intrant.deadlineDate_present() ? QDate(intrant.deadlineDate().year(), intrant.deadlineDate().month(), intrant.deadlineDate().day()) : QDate();
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
    result[DeadlineRole] = "deadline";
    return result;
  }

}
