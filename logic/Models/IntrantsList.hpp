#ifndef MODELS_NEWINTRANTS_HPP
#define MODELS_NEWINTRANTS_HPP

#include "core/Global.hpp"

#include <QAbstractListModel>

#include <QUrl>

#include <memory>
#include <functional>

class QDate;

namespace N_Data {
  class Intrant;
  class IntrantList;
}

namespace N_Models {

  class IntrantsList : public QAbstractListModel
  {
      Q_OBJECT

    public:
      enum IntrantsListRoles {
        TitleRole = Qt::UserRole + 1,
        DescriptionRole,
        DeadlineRole
      };

    public:
      IntrantsList(QObject* a_Parent = Q_NULLPTR);
      ~IntrantsList();

      Q_INVOKABLE void setDate(int a_Idx, const QDate& a_Date);

      std::unique_ptr<N_Data::Intrant> popIntrant(int a_Idx);
      void addIntrant(const N_Data::Intrant& a_Intrant);
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
      QUrl m_IntrantListXsd;
      QString m_LoadedFilename;

      std::unique_ptr<N_Data::IntrantList> m_Data;
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
