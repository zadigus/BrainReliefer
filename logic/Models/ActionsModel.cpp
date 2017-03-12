#include "Models/ActionsModel.hpp"

#include "Models/ModelsHelper.hpp"
#include "Models/IntrantsModel.hpp"

#include "Data/XsdeHelpers.hpp"
#include "Data/DataManager.hpp"

#include "Data/SharedIntrant.hpp"

#include "Data/IntrantsList.hpp"
#include "Data/IntrantsList-pimpl.hpp"

#include <QFile>
#include <QDate>

using namespace std::placeholders;
using namespace N_Data;

namespace N_Models {

  //-------------------------------------------------------------------------------------------
  ActionsModel::ActionsModel(QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_IntrantsListXsd(QStringLiteral("qrc:/xsd/IntrantsList.xsd"))
  { }

  //-------------------------------------------------------------------------------------------
  ActionsModel::~ActionsModel()
  { }

  //-------------------------------------------------------------------------------------------
  void ActionsModel::onIntrantAdded(int a_Idx)
  {
    if(auto intrantsModel = qobject_cast<IntrantsModel*>(sender()))
    {
      addActionsFromIntrant(intrantsModel->getIntrant(a_Idx));
    }
  }

  //-------------------------------------------------------------------------------------------
  void ActionsModel::addActionsFromIntrant(const N_Data::Intrant& a_Item)
  {
    auto projectTitle(QString::fromStdString(a_Item.title()));

    if(a_Item.actions_present())
    {
      auto& actionList(a_Item.actions());
      std::transform(actionList.Action().begin(), actionList.Action().end(), std::back_inserter(m_Data),
                     [&projectTitle](const N_Data::Action& a_Action) -> ProjectAction { return ProjectAction(a_Action, projectTitle); });
    }
  }

  //-------------------------------------------------------------------------------------------
  void ActionsModel::loadDataFromFile(const QString& a_Filename)
  {
    std::unique_ptr<N_Data::IntrantsList> intrantsList(N_XsdeHelpers::loadXML<N_Data::IntrantsList_paggr, N_Data::IntrantsList>(a_Filename, m_IntrantsListXsd));

    beginResetModel();

    m_Data.clear();
    std::for_each(intrantsList->Intrant().begin(), intrantsList->Intrant().end(),
                  std::bind(&ActionsModel::addActionsFromIntrant, this, _1));

    endResetModel();
  }

  //-------------------------------------------------------------------------------------------
  bool ActionsModel::removeRows(int a_Row, int a_Count, const QModelIndex& /*a_Parent*/)
  {
    int lowerIdx(a_Row);
    int upperIdx(a_Row + a_Count - 1);

    beginRemoveRows(QModelIndex(), lowerIdx, upperIdx);
    m_Data.erase(m_Data.begin() + lowerIdx, m_Data.begin() + upperIdx + 1);
    endRemoveRows();

    return true;
  }

  //-------------------------------------------------------------------------------------------
  int ActionsModel::rowCount(const QModelIndex& /*parent*/) const
  {
    return static_cast<int>(m_Data.size());
  }

  //-------------------------------------------------------------------------------------------
  int ActionsModel::columnCount(const QModelIndex& /*parent*/) const
  {
    return 1;
  }

  //-------------------------------------------------------------------------------------------
  QVariant ActionsModel::data(const QModelIndex& a_Index, int a_Role) const
  {
    switch(a_Role)
    {
      case TitleRole:
        return m_Data.at(a_Index.row()).title();
      case ProjectRole:
        return m_Data.at(a_Index.row()).projectTitle();
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
      default:
        break;
    }
    return QVariant();
  }

  //-------------------------------------------------------------------------------------------
  QVariant ActionsModel::headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role) const
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
  QHash<int, QByteArray> ActionsModel::roleNames() const
  {
    QHash<int, QByteArray> result;
    result[TitleRole] = "title";
    result[DelegateRole] = "delegate";
    result[DeadlineRole] = "deadline";
    result[ProjectRole] = "projectTitle";
    return result;
  }

}
