#ifndef MODELS_ACTIONSLIST_HPP
#define MODELS_ACTIONSLIST_HPP

#include "core/Global.hpp"

#include <QAbstractListModel>

#include <QUrl>

namespace N_Models {

  class ActionsList : public QAbstractListModel
  {
      Q_OBJECT

    public:
      enum ActionsListRoles {
        TitleRole = Qt::UserRole + 1,
        DelegateRole,
        DeadlineRole
      };

    public:
      ActionsList(QObject* a_Parent = Q_NULLPTR);
      ~ActionsList();

//      void addActions(const std::vector<Action>& a_Actions); // this is used after we add a new intrant's actions
//      void addAction(const Action& a_Action); // Action is a decorated N_Data::Action
//      void removeAction(int a_Idx);

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const override;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const override;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const override;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const override;

      virtual QHash<int, QByteArray> roleNames() const override;

      virtual bool removeRows(int a_Row, int a_Count, const QModelIndex& a_Parent = QModelIndex()) override;

    private:
      // probably nothing to do
      // when I add an action, I do it either when I process a new intrant (add actions to new intrant)
      // or when I add an action to an existing project ==> the projects list is updated automatically
      // when I remove an action, I do it from the next actions or the projects list
      // ==> when I call removeAction, I am supposed to update the corresponding list
//      void save();

    public slots:
      void loadDataFromFile(const QString& a_FileName);

    private:
      QUrl m_IntrantListXsd;
      QString m_LoadedFilename;

//      std::unique_ptr<N_Data::IntrantList> m_Data;
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
