#ifndef COMMONDATA_ACTION_HPP
#define COMMONDATA_ACTION_HPP

#include "core/Global.hpp"

#include "Data/IntrantsList.hpp"

#include <QString>
#include <QDate>

namespace N_CommonData {

  class Action
  {
    public:
      Action();
      Action(const N_Data::Action& a_Action);
      virtual ~Action();

      N_Data::Action getData() const;

      QString title() const;
      virtual void setTitle(const QString& a_Value);

      QDate deadline() const;
      virtual void setDeadline(const QDate& a_Value);

      QString delegate() const;
      virtual void setDelegate(const QString& a_Value);

    protected:
      std::unique_ptr<N_Data::Action> m_Action;

    private:

  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  inline Action::~Action()
  { }

  //----------------------------------------------------------------------------------
  inline N_Data::Action Action::getData() const
  {
    return *m_Action;
  }

}

#endif // ACTION_HPP
