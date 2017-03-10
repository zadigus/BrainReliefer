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

      N_Data::Action getData() const;

      QString title() const;
      void setTitle(const QString& a_Value);

      QDate deadline() const;
      void setDeadline(const QDate& a_Value);

      QString delegate() const;
      void setDelegate(const QString& a_Value);

    protected:
      std::unique_ptr<N_Data::Action> m_Action;

    private:

  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  inline N_Data::Action Action::getData() const
  {
    return *m_Action;
  }

}

#endif // ACTION_HPP
