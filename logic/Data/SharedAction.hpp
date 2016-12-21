#ifndef DATA_SHAREDACTION_HPP
#define DATA_SHAREDACTION_HPP

#include "core/Global.hpp"

#include "Data/IntrantList.hpp"

#include <QDate>
#include <QObject>

namespace N_Data {

  class SharedAction : public QObject
  {
      Q_OBJECT

      Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
      Q_PROPERTY(QDate deadline READ deadline WRITE setDeadline NOTIFY deadlineChanged)
      Q_PROPERTY(QString delegate READ delegate WRITE setDelegate NOTIFY delegateChanged)

    public:
      explicit SharedAction(QObject* a_Parent = 0);

      Q_INVOKABLE void reset();

      N_Data::Action getAction() const;

      QString title() const;
      void setTitle(const QString& a_Value);

      QDate deadline() const;
      void setDeadline(const QDate& a_Value);

      QString delegate() const;
      void setDelegate(const QString& a_Value);

    signals:
      void titleChanged();
      void deadlineChanged();
      void delegateChanged();

    private:
      std::unique_ptr<Action> m_Data;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  inline N_Data::Action SharedAction::getAction() const
  {
    return *m_Data;
  }

}

#endif
