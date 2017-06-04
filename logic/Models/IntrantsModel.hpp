#ifndef MODELS_INTRANTSMODEL_HPP
#define MODELS_INTRANTSMODEL_HPP

#include "core/Global.hpp"

#include "Data/IntrantsList.hpp"

#include <QAbstractListModel>

#include <QUrl>

class QDate;

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

      virtual void addAction(const N_Data::Action& a_Action, int a_Idx);

      std::unique_ptr<N_Data::Intrant> popIntrant(int a_Idx);
      N_Data::Intrant& getIntrant(int a_Idx) const;
      void addIntrant(std::unique_ptr<N_Data::Intrant> a_Intrant);
      void removeIntrant(int a_Idx);

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const override;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const override;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const override;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const override;

      virtual QHash<int, QByteArray> roleNames() const override;

      virtual bool removeRows(int a_Row, int a_Count, const QModelIndex& a_Parent = QModelIndex()) override;

    public slots:
      void loadDataFromFile(const QString& a_FileName);

    protected:
      void save();

    signals:
      void intrantAdded(int a_Idx);

    protected:
      std::unique_ptr<N_Data::IntrantsList> m_Data;

    private:
      QUrl m_IntrantsListXsd;
      QString m_LoadedFilename;

  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  // non-member method(s)
  //----------------------------------------------------------------------------------
}

#endif // MODELS_NEWINTRANTS_HPP
