#ifndef COMMONDATA_ACTION_HPP
#define COMMONDATA_ACTION_HPP

#include "core/Global.hpp"

#include "Data/IntrantList.hpp"

#include <QString>
#include <QDate>

namespace N_CommonData {

  class Action
  {
    public:
      Action();
      Action(const N_Data::Action& a_Action);

      N_Data::Action getAction() const;

      QString title() const;
      void setTitle(const QString& a_Value);

      QDate deadline() const;
      void setDeadline(const QDate& a_Value);

      QString delegate() const;
      void setDelegate(const QString& a_Value);

    protected:
      N_Data::Action m_Action;

    private:

  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //---------------------------------------------------------------------------------------------------
  inline Action::Action()
    : m_Action("")
  { }

  //---------------------------------------------------------------------------------------------------
  inline Action::Action(const N_Data::Action& a_Action)
    : m_Action(a_Action)
  { }

  inline N_Data::Action Action::getAction() const
  {
    return m_Action;
  }

}

#endif // ACTION_HPP
