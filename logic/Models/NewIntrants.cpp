#include "Models/NewIntrants.hpp"

#include "Models/ModelsHelper.hpp"

#include "Data/DataValidator.hpp"

#include "Data/IntrantList.hpp"

#include <QDebug>
#include <QFile>

using namespace N_Data;

// TODO:
// * implement save functionality

namespace N_Models {

  //-------------------------------------------------------------------------------------------
  NewIntrants::NewIntrants(const QString& a_PathToXml, const QString& a_PathToXsd, QObject* a_Parent)
    : QAbstractListModel(a_Parent)
    , m_PathToXml(a_PathToXml)
    , m_PathToXsd(a_PathToXsd)
  {

  }

  //-------------------------------------------------------------------------------------------
  NewIntrants::~NewIntrants()
  {

  }

  //-------------------------------------------------------------------------------------------
  void NewIntrants::reload()
  {    
    QFile xsdFile(m_PathToXsd);
    QFile xmlFile(m_PathToXml);

    if(!xsdFile.exists())
    {
      qFatal("Schema file %s does not exist.", m_PathToXsd.toStdString()); // TODO: this is a critical error; maybe throw an exception
    }

    if(!xmlFile.exists())
    {
      qFatal("Data file %s does not exist.", m_PathToXml.toStdString()); // TODO: this is no problem in principle as the user may not have saved data yet
    }

    if(!N_DataValidator::isXMLDataValid(xsdFile, xmlFile))
    {
      qFatal("Invalid XML file %s", xmlFile); // TODO: deal with that case
      // e.g. it could be that the file doesn't exist yet
    }

    beginResetModel();
    m_Data = IntrantList_(N_ModelsHelper::pathToData(xmlFile));

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
