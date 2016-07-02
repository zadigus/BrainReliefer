#include "Logger.hpp"

#include "LoggerExceptions.hpp"

#include "Data/Application.hpp"

#include <algorithm>
#include <functional>

#include <iostream>

using namespace std::placeholders;

namespace N_Logger {

  //----------------------------------------------------------------------------------------------
  Logger::Logger()
    : m_INFLog(new OFFLog)
    , m_WRNLog(new OFFLog)
    , m_ERRLog(new OFFLog)
  {
    m_VerboseLevels.emplace("INF", 1);
    m_VerboseLevels.emplace("WRN", 2);
    m_VerboseLevels.emplace("ERR", 3);
  }

  //----------------------------------------------------------------------------------------------
  Logger::~Logger()
  {
    m_Stream.close();
  }

  //----------------------------------------------------------------------------------------------
  void Logger::init(const N_ApplicationData::Log& a_LogParams)
  {
    m_Stream.open(a_LogParams.Filename(), std::ios::out);

    switch (m_VerboseLevels[a_LogParams.Mode() ? *(a_LogParams.Mode()) : "INF"])
    {
      case 1:
        m_INFLog.reset(new INFLog);
      case 2:
        m_WRNLog.reset(new WRNLog);
      case 3:
        m_ERRLog.reset(new ERRLog);
        break;
      default:
        throw XUnknownLogMode("Unknown log mode");
    }
  }

  //----------------------------------------------------------------------------------------------
  std::string Logger::coreMessage(const std::string& aFctSig, const std::string& aFileName, int aLineNb) const
  {
    std::string tmp("[" + getDate() + "]");
    if (!aFctSig.empty())
      tmp += "[" + aFctSig + "]";
    if (!aFileName.empty())
      tmp += "[" + aFileName + "]";
    if (aLineNb)
      tmp += "[" + std::to_string(aLineNb) + "]";
    return tmp;
  }

  //----------------------------------------------------------------------------------------------
  std::string Logger::getDate() const
  {
    time_t rawtime;
    unsigned int dateSize(80);

    time(&rawtime);
    struct tm* timeinfo = localtime(&rawtime);
    char* tmp = new char[dateSize];
    strftime(tmp, dateSize, "%d/%m/%Y %H:%M:%S", timeinfo);
    std::string theDate(tmp);
    delete[] tmp;

    return theDate;
  }
}
