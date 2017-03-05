#ifndef DATA_SHAREDACTION_HPP
#define DATA_SHAREDACTION_HPP

#include "core/Global.hpp"

#include "common/Data/Action.hpp"

#include <QDate>
#include <QObject>

namespace N_Data {

  class SharedAction : public QObject, public N_CommonData::Action
  {
      Q_OBJECT

      Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
      Q_PROPERTY(QDate deadline READ deadline WRITE setDeadline NOTIFY deadlineChanged)
      Q_PROPERTY(QString delegate READ delegate WRITE setDelegate NOTIFY delegateChanged)

    public:
      explicit SharedAction(QObject* a_Parent = 0);

      Q_INVOKABLE void reset();

    signals:
      void titleChanged();
      void deadlineChanged();
      void delegateChanged();

    private:
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //---------------------------------------------------------------------------------------------------
  inline SharedAction::SharedAction(QObject* a_Parent)
    : QObject(a_Parent)
  { }

}

#endif
