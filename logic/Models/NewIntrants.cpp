#include "Models/NewIntrants.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataValidator.hpp"
#include "Data/DataManager.hpp"
#include "Data/DataExceptions.hpp"

#include "Data/IntrantList.hpp"

#include <QDebug>
#include <QFile>

using namespace N_Data;

// TODO:
// * implement save functionality

namespace N_Models {

  //-------------------------------------------------------------------------------------------
  NewIntrants::NewIntrants(QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_IntrantListXsd(QStringLiteral("qrc:/xsd/IntrantList.xsd"))
  {

  }

  //-------------------------------------------------------------------------------------------
  NewIntrants::~NewIntrants()
  {

  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::loadData (const QString& a_FileName)
  {
    try
    {
      auto DataBuilder = [] (const std::string& a_FileName) { return IntrantList_(a_FileName); };
      QFile file(a_FileName);
      m_Data = N_DataManagerHelper::getParsedXML<IntrantList>(file, m_IntrantListXsd, DataBuilder);
    }
    catch(const XInexistentData& ex)
    {
      qDebug() << "Caught exception: " << ex.what();
    }
    catch(const XInvalidData& ex)
    {
      qDebug() << "Caught exception: " << ex.what();
      // TODO: if the data does not exist, then automatically create the missing file in the same directory as the main Data.xml
    }
  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::reload(const QString& a_FileName)
  {    
    beginResetModel();

    loadData(a_FileName);

    QModelIndex parentIndex = QModelIndex();
    QModelIndex topLeft     = index(0, 0, parentIndex);
    QModelIndex bottomRight = index(rowCount(parentIndex) - 1,
                                    columnCount(parentIndex) - 1, parentIndex);

    beginInsertRows(parentIndex, 0, static_cast<int>(m_Data->Intrant().size()) - 1);
    endInsertRows();

    emit dataChanged(topLeft, bottomRight);
    endResetModel();
  }

  //-------------------------------------------------------------------------------------------
  int NewIntrants::rowCount(const QModelIndex& /*parent*/) const
  {
    if(m_Data)
    {
      return static_cast<int>(m_Data->Intrant().size());
    }

    return 0;
  }

  //-------------------------------------------------------------------------------------------
  int NewIntrants::columnCount(const QModelIndex& /*parent*/) const
  {
    return 1;
  }

  //-------------------------------------------------------------------------------------------
  QVariant NewIntrants::data(const QModelIndex& a_Index, int a_Role) const
  {
    if(a_Role == TitleRole)
    {
      return QString::fromStdString(m_Data->Intrant().at(a_Index.row()).title());
    }
    return QVariant();
  }

  //-------------------------------------------------------------------------------------------
  QVariant NewIntrants::headerData(int a_Section, Qt::Orientation a_Orientation, int a_Role) const
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

//  bool NewIntrants::insertRows(int a_Row, int a_Count, const QModelIndex& a_Parent)
//  {

//  }

//  bool NewIntrants::removeRows(int a_Row, int a_Count, const QModelIndex& a_Parent)
//  {

//  }

//  //-------------------------------------------------------------------------------------------
//  bool NewIntrants::setData(const QModelIndex& index, const QVariant& value, int role)
//  {

//  }

//  //-------------------------------------------------------------------------------------------
//  Qt::ItemFlags NewIntrants::flags(const QModelIndex& index) const
//  {

//  }

  //-------------------------------------------------------------------------------------------
  QHash<int, QByteArray> NewIntrants::roleNames() const
  {
    QHash<int, QByteArray> result;
    result[TitleRole] = "title";
    return result;
  }

}
