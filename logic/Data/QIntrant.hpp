#ifndef DATA_QINTRANT_HPP
#define DATA_QINTRANT_HPP

#include <QObject>

namespace N_Data {

  class QIntrant : public QObject
  {
      Q_OBJECT

      Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
      Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)

    public:
      explicit QIntrant(QObject *a_Parent = 0);

      Q_INVOKABLE void clear();

      QString title() const;
      void setTitle(const QString& a_Value);

      QString description() const;
      void setDescription(const QString& a_Value);

    signals:
      void titleChanged();
      void descriptionChanged();

    public slots:

    private:
      QString m_Title;
      QString m_Description;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  inline QIntrant::QIntrant(QObject *a_Parent)
    : QObject(a_Parent)
  { }

  inline void QIntrant::clear()
  {
    m_Title.clear();
    m_Description.clear();
  }

  inline QString QIntrant::title() const
  {
    return m_Title;
  }

  inline void QIntrant::setTitle(const QString& a_Value)
  {
    m_Title = a_Value;
  }

  inline QString QIntrant::description() const
  {
    return m_Description;
  }

  inline void QIntrant::setDescription(const QString& a_Value)
  {
    m_Description = a_Value;
  }

}

#endif // QINTRANT_HPP
