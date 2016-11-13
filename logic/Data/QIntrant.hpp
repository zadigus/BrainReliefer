#ifndef DATA_QINTRANT_HPP
#define DATA_QINTRANT_HPP

#include "core/Global.hpp"

#include "Data/IntrantList.hpp"

#include <QObject>

namespace N_Data {

  class QIntrant : public QObject
  {
      Q_OBJECT

      Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
      Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)

    public:
      explicit QIntrant(QObject *a_Parent = 0);

      Q_INVOKABLE void reset();

      N_Data::Intrant getIntrant() const;

      QString title() const;
      void setTitle(const QString& a_Value);

      QString description() const;
      void setDescription(const QString& a_Value);

    signals:
      void titleChanged();
      void descriptionChanged();

    public slots:

    private:
      static const N_Data::Intrant::title_type DEFAULT_TITLE;
//      static const N_Data::Intrant::ID_type DEFAULT_ID;

      std::unique_ptr<N_Data::Intrant> m_Data;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  inline N_Data::Intrant QIntrant::getIntrant() const
  {
    return *m_Data;
  }

}

#endif // QINTRANT_HPP
