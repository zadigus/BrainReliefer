#ifndef APPCONFIGURATION_HPP
#define APPCONFIGURATION_HPP

#include "core/Global.hpp"

#include <QObject>

class AppConfiguration : public QObject
{
  Q_OBJECT

  Q_PROPERTY(QString dataDir READ dataDir WRITE setDataDir NOTIFY dataDirChanged)

  public:
    explicit AppConfiguration(QObject* a_Parent = 0);

    void setup();

    QString dataDir() const;
    void setDataDir(const QString& a_Value);

  public slots:

  private:
    void setupData();

  signals:
    void dataDirChanged();

  private:
    QString m_DataDir;
};

inline QString AppConfiguration::dataDir () const
{
  return m_DataDir;
}

#endif // APPCONFIGURATION_HPP
