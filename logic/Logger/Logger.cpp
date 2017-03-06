#include "Logger.hpp"

#include <fstream>

#include <QApplication>
#include <QDate>
#include <QFileInfo>
#include <QDir>
#include <QSettings>
#include <QStandardPaths>
#include <QFile>

#include <QDebug>

#include <QMessageBox>
#include <QApplication>

namespace N_Logger {

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

    QFile outFile(filename());
    if(outFile.open(QIODevice::Append | QIODevice::Text))
    {
      QTextStream ts(&outFile);
      QString result(msg.join(" "));
      ts << result << endl;
    }
    else
    {
      QMessageBox::information(QApplication::activeWindow(), "Impossible to write into log file", filename());
    }
    outFile.close();
  }

  //----------------------------------------------------------------------------------------------
  QString coreMessage(const QMessageLogContext& a_Context)
  {
    QStringList result;
    result << "[";
    result << QDate::currentDate().toString();
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
