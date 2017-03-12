#include "Models/IntrantsModel.hpp"

#include "Models/ModelsHelper.hpp"

#include "Data/XsdeHelpers.hpp"
#include "Data/DataManager.hpp"

#include "Data/IntrantsList-pimpl.hpp"
#include "Data/IntrantsList-simpl.hpp"

#include <QFile>
#include <QDate>

using namespace N_Data;

namespace N_Models {

  //-------------------------------------------------------------------------------------------
  IntrantsModel::IntrantsModel(QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_IntrantsListXsd(QStringLiteral("qrc:/xsd/IntrantsList.xsd"))
  { }

  //-------------------------------------------------------------------------------------------
  IntrantsModel::~IntrantsModel()
  { }

  //-------------------------------------------------------------------------------------------
  void IntrantsModel::setDate(int a_Idx, const QDate& a_Date)
  {
    auto& intrant(m_Data->Intrant()[a_Idx]);
    intrant.deadlineDate(xml_schema::date(a_Date.year(), a_Date.month(), a_Date.day()));

    QModelIndex currentIdx(index(a_Idx, columnCount() - 1));
    emit dataChanged(currentIdx, currentIdx);
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsModel::save()
  {
    qInfo() << "Storing the data in the file <" << m_LoadedFilename << ">.";
    N_XsdeHelpers::serializeXML<IntrantsList_saggr, IntrantsList>(m_LoadedFilename.toStdString(), *m_Data);
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsModel::addAction(const N_Data::Action& a_Action, int a_Idx)
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
      std::unique_ptr<ActionsList> actionsList(new ActionsList);
      actionsList->Action().push_back(a_Action);
      intrant.actions(actionsList.release());
    }

    QModelIndex currentIdx(index(a_Idx, columnCount() - 1));
    emit dataChanged(currentIdx, currentIdx);

    // TODO: only save if you are in the project model; in the newIntrantsModel, this shouldn't be saved
    save();
  }

  //-------------------------------------------------------------------------------------------
  N_Data::Intrant& IntrantsModel::getIntrant(int a_Idx) const
  {
    return m_Data->Intrant()[a_Idx];
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsModel::removeIntrant(int a_Idx)
  {
    qInfo() << QString::fromStdString("Deleting intrant");

    removeRow(a_Idx);
    save();
  }

  //-------------------------------------------------------------------------------------------
  std::unique_ptr<Intrant> IntrantsModel::popIntrant(int a_Idx)
  {
    auto& seq(m_Data->Intrant());
    auto it(seq.begin() + a_Idx);
    std::unique_ptr<Intrant> result(seq.detach(it)); // sets the array element a_Idx to NULL
    qInfo() << "Popping out intrant with title <" << QString::fromStdString(result->title()) << ">";
    removeIntrant(a_Idx); // removes the element a_Idx from the array
    return result;
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsModel::addIntrant(std::unique_ptr<N_Data::Intrant> a_Intrant)
  {
    qInfo() << "Adding new intrant with title <" << QString::fromStdString(a_Intrant->title()) << ">.";

    int idx(static_cast<int>(m_Data->Intrant().size()));
    beginInsertRows(QModelIndex(), idx, idx);
    m_Data->Intrant().push_back(a_Intrant.release());
    endInsertRows();
    emit intrantAdded(idx);
    save();
  }

  //-------------------------------------------------------------------------------------------
  void IntrantsModel::loadDataFromFile(const QString& a_Filename)
  {
    qInfo() << "Loading file " << a_Filename;

    beginResetModel();
    m_Data = N_XsdeHelpers::loadXML<N_Data::IntrantsList_paggr, N_Data::IntrantsList>(a_Filename, m_IntrantsListXsd);
    m_LoadedFilename = a_Filename;
    endResetModel();
  }

  //-------------------------------------------------------------------------------------------
  bool IntrantsModel::removeRows(int a_Row, int a_Count, const QModelIndex& /*a_Parent*/)
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
  int IntrantsModel::rowCount(const QModelIndex& /*parent*/) const
  {
    if(m_Data)
    {
      return static_cast<int>(m_Data->Intrant().size());
    }

    return 0;
  }

  //-------------------------------------------------------------------------------------------
  int IntrantsModel::columnCount(const QModelIndex& /*parent*/) const
  {
    return 1;
  }

  //-------------------------------------------------------------------------------------------
  QVariant IntrantsModel::data(const QModelIndex& a_Index, int a_Role) const
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
  QVariant IntrantsModel::headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role) const
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
  QHash<int, QByteArray> IntrantsModel::roleNames() const
  {
    QHash<int, QByteArray> result;
    result[TitleRole] = "title";
    result[DescriptionRole] = "description";
    result[DeadlineRole] = "deadline";
    return result;
  }

}
