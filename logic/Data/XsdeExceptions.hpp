#ifndef DATA_XSDEEXCEPTIONS_HPP
#define DATA_XSDEEXCEPTIONS_HPP

#include "core/Global.hpp"

#include <QUrl>
#include <QFile>

#include <stdexcept>

namespace N_Data {

  class XInvalidData : public std::exception
  {
    public:
      XInvalidData(const QString& a_Xml, const QUrl& a_Xsd) : m_Xml(a_Xml), m_Xsd(a_Xsd) { }
      virtual ~XInvalidData() { }

      virtual const char* what() const NOEXCEPT override;

    private:
      QString m_Xml;
      QUrl m_Xsd;
  };

}

#endif // DATA_DATAEXCEPTIONS_HPP
