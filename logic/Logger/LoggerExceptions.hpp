#ifndef LOGGER_LOGGEREXCEPTIONS_HPP
#define LOGGER_LOGGEREXCEPTIONS_HPP

#include <stdexcept>

namespace N_Logger {

  class XUnknownLogMode : public std::runtime_error
  {
    public:
      XUnknownLogMode(const std::string& a_Msg) : std::runtime_error(a_Msg) { }
      virtual ~XUnknownLogMode() { }
  };

}

#endif // LOGGEREXCEPTIONS_HPP
