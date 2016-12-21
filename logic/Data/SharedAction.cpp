#include "SharedAction.hpp"

#include <QDate>

namespace N_Data {

  //---------------------------------------------------------------------------------------------------
  SharedAction::SharedAction(QObject *a_Parent)
    : QObject(a_Parent)
  {
    reset();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::reset()
  {
    m_Data.reset(new N_Data::Action(""));
  }

  //---------------------------------------------------------------------------------------------------
  QString SharedAction::title() const
  {
    return QString::fromStdString(m_Data->title());
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::setTitle(const QString& a_Value)
  {
    m_Data->title(a_Value.toStdString());
  }

  //---------------------------------------------------------------------------------------------------
  QDate SharedAction::deadline() const
  {
    auto value(m_Data->deadlineDate());
    return value.present() ? QDate((*value).year(), (*value).month(), (*value).day()) : QDate();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::setDeadline(const QDate& a_Value)
  {
    m_Data->deadlineDate(Action::deadlineDate_type(a_Value.year(), a_Value.month(), a_Value.day()));
  }

  //---------------------------------------------------------------------------------------------------
  QString SharedAction::delegate() const
  {
    return m_Data->delegate().present() ? QString::fromStdString(*(m_Data->delegate())) : QString();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::setDelegate(const QString& a_Value)
  {
    m_Data->delegate(a_Value.toStdString());
  }
}
