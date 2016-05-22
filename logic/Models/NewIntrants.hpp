#ifndef MODELS_NEWINTRANTS_HPP
#define MODELS_NEWINTRANTS_HPP

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

      Q_INVOKABLE void reload();

      virtual int rowCount(const QModelIndex& a_Parent = QModelIndex()) const;
      virtual int columnCount(const QModelIndex& a_Parent = QModelIndex()) const;

      virtual QVariant data(const QModelIndex& a_Index, int a_Role = Qt::DisplayRole) const;
      virtual QVariant headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role = Qt::DisplayRole) const;

//      virtual bool insertRows(int a_Row, int a_Count, const QModelIndex& a_Parent = QModelIndex());
//      virtual bool removeRows(int a_Row, int a_Count, const QModelIndex& a_Parent = QModelIndex());

//      virtual bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);
//      virtual Qt::ItemFlags flags(const QModelIndex &index) const;

      virtual QHash<int, QByteArray> roleNames() const;

    private:
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
