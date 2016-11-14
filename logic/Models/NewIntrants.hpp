#ifndef MODELS_NEWINTRANTS_HPP
#define MODELS_NEWINTRANTS_HPP

#include "core/Global.hpp"

#include "Data/QIntrant.hpp"

#include <QAbstractListModel>

#include <QUrl>

#include <memory>

namespace N_Data {
  class IntrantList;
}

namespace N_Models {

  class NewIntrants : public QAbstractListModel
  {
      Q_OBJECT

    public:
      enum NewIntrantsRoles {
        TitleRole = Qt::UserRole + 1,
        DescriptionRole
      };

    public:
      NewIntrants(QObject* a_Parent = Q_NULLPTR);
      ~NewIntrants();

      Q_INVOKABLE void addIntrant(QObject* a_Intrant);

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const;

      virtual QHash<int, QByteArray> roleNames() const;

    private:
      void loadData (const QString& a_FileName);
      void reload();
      void store(const N_Data::IntrantList& a_List);

    public slots:
      void reload(const QString& a_FileName);

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

}

#endif // MODELS_NEWINTRANTS_HPP
