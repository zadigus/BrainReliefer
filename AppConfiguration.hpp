#ifndef APPCONFIGURATION_HPP
#define APPCONFIGURATION_HPP

#include <QObject>

#include <QUrl>

class AppConfiguration : public QObject
{
  Q_OBJECT

  Q_PROPERTY(QUrl dataFileUrl READ dataFileUrl WRITE setDataFileUrl NOTIFY dataFileUrlChanged)

  public:
    explicit AppConfiguration(QObject* a_Parent = 0);

    void setup();

    QUrl dataFileUrl() const;
    void setDataFileUrl(const QUrl& a_Value);

  signals:
    void dataFileUrlChanged();

  public slots:

  private:
    QUrl m_ConfXmlUrl;
    QUrl m_ConfXsdUrl;
    QUrl m_DataFileUrl;
};

inline QUrl AppConfiguration::dataFileUrl () const
{
  return m_DataFileUrl;
}

#endif // APPCONFIGURATION_HPP
