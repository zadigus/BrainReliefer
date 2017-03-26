#include "Logger.hpp"

#include "core/Utils.hpp"

#include <QApplication>
#include <QDate>
#include <QFileInfo>
#include <QDir>
#include <QSettings>
#include <QStandardPaths>

namespace N_Logger {

  //----------------------------------------------------------------------------------------------
  void resetLogFile()
  {
    QFile logFile(N_Logger::filename());
    if(!logFile.exists())
    {
      logFile.open(QIODevice::WriteOnly | QIODevice::Text);
      logFile.close();
    }
  }

  //----------------------------------------------------------------------------------------------
  QString filename()
  {
    QDir logDir(QStandardPaths::standardLocations(QStandardPaths::HomeLocation)[0]);
    return logDir.absoluteFilePath(QCoreApplication::applicationName().append(".log"));
  }

  //----------------------------------------------------------------------------------------------
  void message(QtMsgType a_MsgType, const QMessageLogContext& a_Context, const QString& a_Msg)
  {
    QByteArray localMsg(a_Msg.toLocal8Bit());

    QStringList msg;

    switch(a_MsgType)
    {
     case QtDebugMsg:
        msg << "[DBG]";
        break;
      case QtWarningMsg:
        msg << "[WRN]";
        break;
      case QtCriticalMsg:
        msg << "[CRT]";
        break;
      case QtFatalMsg:
        msg << "[FTL]";
        break;
      case QtInfoMsg:
        msg << "[INF]";
        break;
      default:
        break;
    }

    msg << coreMessage(a_Context);
    msg << localMsg.constData();
    msg << "\n";

    N_Utils::writeTextToFile(filename(), QIODevice::Append, msg.join(" "));
  }

  //----------------------------------------------------------------------------------------------
  QString coreMessage(const QMessageLogContext& a_Context)
  {
    QStringList result;
    result << "[";
    result << QDateTime::currentDateTime().toString();
    result << "]";

    result << "[";
    result << a_Context.function;
    result << "]";

    result << "[";
    result << a_Context.file;
    result << "]";

    result << "[";
    result << QString::number(a_Context.line);
    result << "]";

    return result.join(" ");
  }

}
