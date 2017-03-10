#ifndef MODELS_INTRANTSLIST_HPP
#define MODELS_INTRANTSLIST_HPP

#include "core/Global.hpp"

#include <QAbstractListModel>

#include <QUrl>

class QDate;

namespace N_Data {
  class Action;
  class Intrant;
  class IntrantsList;
}

namespace N_Models {

  class IntrantsModel : public QAbstractListModel
  {
      Q_OBJECT

    public:
      enum IntrantsListRoles {
        TitleRole = Qt::UserRole + 1,
        DescriptionRole,
        DeadlineRole
      };

    public:
      IntrantsModel(QObject* a_Parent = Q_NULLPTR);
      ~IntrantsModel();

      Q_INVOKABLE void setDate(int a_Idx, const QDate& a_Date);

      void addAction(const N_Data::Action& a_Action, int a_Idx);

      std::unique_ptr<N_Data::Intrant> popIntrant(int a_Idx);
      void addIntrant(std::unique_ptr<N_Data::Intrant> a_Intrant);
      void removeIntrant(int a_Idx);

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const override;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const override;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const override;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const override;

      virtual QHash<int, QByteArray> roleNames() const override;

      virtual bool removeRows(int a_Row, int a_Count, const QModelIndex& a_Parent = QModelIndex()) override;

    private:
      void save();

    public slots:
      void loadDataFromFile(const QString& a_FileName);

    private:
      QUrl m_IntrantsListXsd;
      QString m_LoadedFilename;

      std::unique_ptr<N_Data::IntrantsList> m_Data;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  // non-member method(s)
  //----------------------------------------------------------------------------------
}

#endif // MODELS_NEWINTRANTS_HPP
