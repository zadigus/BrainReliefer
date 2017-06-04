#ifndef MODELS_ACTIONSMODEL_HPP
#define MODELS_ACTIONSMODEL_HPP

#include "core/Global.hpp"

#include <QAbstractListModel>
#include <QUrl>

namespace N_Data {
  class Intrant;
  class Action;
}

namespace N_Models {
  class ProjectAction;
}

namespace N_Models {

  class ActionsModel : public QAbstractListModel
  {
      Q_OBJECT

    public:
      enum ActionsListRoles {
        TitleRole = Qt::UserRole + 1,
        DelegateRole,
        DeadlineRole,
        ProjectRole
      };

    public:
      ActionsModel(QObject* a_Parent = Q_NULLPTR);
      ~ActionsModel();

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const override;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const override;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const override;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const override;

      virtual QHash<int, QByteArray> roleNames() const override;

      virtual bool removeRows(int a_Row, int a_Count, const QModelIndex& a_Parent = QModelIndex()) override;

      Q_INVOKABLE void remove(int a_Row);

    public slots:
      void loadDataFromFile(const QString& a_Filename);
      void onIntrantAdded(int a_IntrantIdx);
      void onActionAdded(int a_IntrantIdx, int a_ActionIdx);

    private:
      void addActionsFromIntrant(const N_Data::Intrant& a_Item);
      void addActionFromIntrant(const N_Data::Intrant& a_Item, int a_ActionIdx);

      std::shared_ptr<ProjectAction> createProjectAction(const N_Data::Action& a_Action, const QString& a_ProjectTitle);

    signals:
      void deleted(const QString& a_ActionTitle, const QString& a_ProjectTitle);

    private:
      QUrl m_IntrantsListXsd;

      std::vector<std::shared_ptr<ProjectAction> > m_Data;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  // non-member method(s)
  //----------------------------------------------------------------------------------
  QModelIndex parentIndex();
}

#endif // MODELS_NEWINTRANTS_HPP
