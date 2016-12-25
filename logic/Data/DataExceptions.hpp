#ifndef DATA_DATAEXCEPTIONS_HPP
#define DATA_DATAEXCEPTIONS_HPP

#include <QUrl>
#include <QFile>

#include <stdexcept>

namespace N_Data {

  class XInvalidData : public std::exception
  {
    public:
      XInvalidData(const QString& a_Xml, const QUrl& a_Xsd) : m_Xml(a_Xml), m_Xsd(a_Xsd) { }
      virtual ~XInvalidData() { }

      virtual const char* what() const noexcept override;

    private:
      QString m_Xml;
      QUrl m_Xsd;
  };

  class XInexistentData : public std::runtime_error
  {
    public:
      XInexistentData(const std::string& a_Msg) : std::runtime_error(a_Msg) { }
      virtual ~XInexistentData() { }
  };

}

#endif // DATA_DATAEXCEPTIONS_HPP
