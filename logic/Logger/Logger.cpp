#include "Logger.hpp"

#include <fstream>

#include <QApplication>
#include <QDate>
#include <QFileInfo>
#include <QDir>
#include <QSettings>

#include <QFile>

#include <QDebug>

namespace N_Logger {

  //----------------------------------------------------------------------------------------------
  QString filename()
  {
    QSettings setting;
    setting.beginGroup("Logs");
//    auto result(setting.value("Filename", QFileInfo(setting.fileName()).dir().absoluteFilePath(QCoreApplication::applicationName().append(".log"))).toString());
    auto result(setting.value("Filename", "/sdcard/BrainReliefer.log").toString());
    setting.endGroup();
    return result;
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

    QFile file(filename());
    if(file.open(QIODevice::ReadWrite))
    {
      QTextStream stream(&file);
      stream << "hahahaha";
    }
    else
    {
      qDebug() << "impossible to write into that bloody file";
    }

//    auto file(filename());
//    std::ofstream ofs(filename().toStdString(), std::ios::out);
//    ofs << msg.join(" ").toStdString() << std::endl;
//    ofs.close();
//    qDebug() << msg.join(" ");
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
