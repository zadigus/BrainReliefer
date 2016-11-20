#ifndef DATA_SHAREDINTRANT_HPP
#define DATA_SHAREDINTRANT_HPP

#include "core/Global.hpp"

#include "Data/IntrantList.hpp"

#include <QObject>

namespace N_Data {

  class SharedIntrant : public QObject
  {
      Q_OBJECT

      Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
      Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)

    public:
      explicit SharedIntrant(QObject* a_Parent = Q_NULLPTR);

      Q_INVOKABLE void reset();

      Intrant getIntrant() const;

      QString title() const;
      void setTitle(const QString& a_Value);

      QString description() const;
      void setDescription(const QString& a_Value);

    signals:
      void titleChanged();
      void descriptionChanged();

    private:
      std::unique_ptr<Intrant> m_Data;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  inline Intrant SharedIntrant::getIntrant() const
  {
    return *m_Data;
  }

}

#endif // DATA_SHAREDINTRANT_HPP
