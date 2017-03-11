#ifndef APPCONFIGURATION_HPP
#define APPCONFIGURATION_HPP

#include "core/Global.hpp"

#include <QObject>
#include <QUrl>

class AppConfiguration : public QObject
{
  Q_OBJECT

  Q_PROPERTY(QUrl dataDir READ dataDir WRITE setDataDir NOTIFY dataDirChanged)

  public:
    explicit AppConfiguration(QObject* a_Parent = 0);

    void setup();

    QUrl dataDir() const;
    void setDataDir(const QUrl& a_Value);

  public slots:

  private:
    void setupData();

  signals:
    void dataDirChanged();

  private:
    QUrl m_DataDir;
};

inline QUrl AppConfiguration::dataDir() const
{
  return m_DataDir;
}

#endif // APPCONFIGURATION_HPP
