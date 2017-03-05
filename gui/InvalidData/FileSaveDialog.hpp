#ifndef FILESAVEDIALOG_HPP
#define FILESAVEDIALOG_HPP

#include "core/Global.hpp"

#include <QQuickItem>

namespace N_Data {
  class DataPath;
}

class FileSaveDialog : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QUrl     filenameUrl READ filenameUrl                        NOTIFY filenameUrlChanged)
    Q_PROPERTY(QString  title       READ title        WRITE setTitle        NOTIFY titleChanged)
    Q_PROPERTY(QString  nameFilters READ nameFilters  WRITE setNameFilters  NOTIFY nameFiltersChanged)

  public:
    explicit FileSaveDialog(QQuickItem* a_Parent = NULL);

    QUrl filenameUrl() const;

    QString title() const;
    void setTitle(const QString& a_Title);

    QString nameFilters() const;
    void setNameFilters(const QString& a_NameFilters);

    Q_INVOKABLE bool open ();
    Q_INVOKABLE void createNewDataFile ();

  signals:
    void filenameUrlChanged();
    void titleChanged();
    void nameFiltersChanged();

  private Q_SLOTS:

  private:

  private:
    QString m_Filename;
    QString m_Title;
    QString m_NameFilters;

    Q_DISABLE_COPY(FileSaveDialog)
};

//----------------------------------------------------------------------------------
// non-member method(s)
//----------------------------------------------------------------------------------

N_Data::DataPath dataPath(const std::string& a_Path, const std::string& a_Name); // TODO: move that into a dedicated namespace

//----------------------------------------------------------------------------------
// inline / template method(s) implementation
//----------------------------------------------------------------------------------

inline QString FileSaveDialog::title() const
{
  return m_Title;
}

inline void FileSaveDialog::setTitle(const QString& a_Title)
{
  m_Title = a_Title;
  emit titleChanged();
}

inline QString FileSaveDialog::nameFilters() const
{
  return m_NameFilters;
}

inline void FileSaveDialog::setNameFilters(const QString& a_NameFilters)
{
  m_NameFilters = a_NameFilters;
  emit nameFiltersChanged();
}

#endif // FILESAVEDIALOG_HPP
