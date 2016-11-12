#ifndef MODELS_NEWINTRANTS_HPP
#define MODELS_NEWINTRANTS_HPP

#include "core/Global.hpp"

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
        TitleRole = Qt::UserRole + 1
      };

    public:
      NewIntrants(QObject* a_Parent = Q_NULLPTR);
      ~NewIntrants();

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const;

      virtual QHash<int, QByteArray> roleNames() const;

    private:
      void loadData (const QString& a_FileName);

    public slots:
      void reload(const QString& a_FileName);

    private:
      QUrl m_IntrantListXsd;

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
