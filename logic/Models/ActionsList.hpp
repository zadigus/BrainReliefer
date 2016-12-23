#ifndef MODELS_ACTIONSLIST_HPP
#define MODELS_ACTIONSLIST_HPP

#include "core/Global.hpp"

#include "ProjectAction.hpp"

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
        DeadlineRole,
        ProjectRole
      };

    public:
      ActionsList(QObject* a_Parent = Q_NULLPTR);
      ~ActionsList();

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const override;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const override;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const override;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const override;

      virtual QHash<int, QByteArray> roleNames() const override;

      virtual bool removeRows(int a_Row, int a_Count, const QModelIndex& a_Parent = QModelIndex()) override;

    public slots:
      void loadDataFromFile(const QString& a_FileName);

    private:


    private:
      QUrl m_IntrantListXsd;

      std::vector<ProjectAction> m_Data;
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
