#include "FileSaveDialog.hpp"

#include "Data/DataConstants.hpp"
#include "Data/Data.hpp"

#include <QApplication>
#include <QtWidgets/QFileDialog>
#include <QFileInfo>

#include <fstream>

using namespace N_Data;

//----------------------------------------------------------------------------------------------
FileSaveDialog::FileSaveDialog(QQuickItem* a_Parent)
  : QQuickItem(a_Parent)
{
  // double-check that we are in QApplication and not just a QGuiApplication for example
  // because we need QWidget support as the dialog is a QWidget
  QApplication *appHasQtWidgetsSupport = qobject_cast<QApplication*>(QCoreApplication::instance());
  Q_ASSERT(appHasQtWidgetsSupport);
}

//----------------------------------------------------------------------------------------------
DataPath dataPath(const std::string& a_Path, const std::string& a_Name)
{
  DataPath result;
  result.name(a_Name);
  result.assign(a_Path);
  return result;
}

//----------------------------------------------------------------------------------------------
void FileSaveDialog::createNewDataFile ()
{
  Data newData;
  RootDir rootDir;
  rootDir.assign(QFileInfo(m_Filename).absoluteDir().absolutePath().toStdString());
  newData.RootDir(rootDir);

  Data::DataPath_sequence& pathSeq(newData.DataPath());
  pathSeq.push_back(dataPath("NewIntrants.xml",   N_Data::NEW_INTRANTS_ITEMS));
  pathSeq.push_back(dataPath("Incubation.xml",    N_Data::INCUBATION_ITEMS));
  pathSeq.push_back(dataPath("References.xml",    N_Data::REFERENCE_ITEMS));
  pathSeq.push_back(dataPath("Projects.xml",      N_Data::PROJECT_ITEMS));
  pathSeq.push_back(dataPath("NextActions.xml",   N_Data::NEXT_ACTIONS));
  pathSeq.push_back(dataPath("Agenda.xml",        N_Data::AGENDA_ITEMS));

  // TODO: implement the serialization!
//  std::ofstream ofs(m_Filename.toStdString());
//  Data_(ofs, newData);
}

//----------------------------------------------------------------------------------------------
bool FileSaveDialog::open()
{
  m_Filename = QFileDialog::getSaveFileName(
                 NULL,
                 m_Title,
                 QDir::homePath(),
                 m_NameFilters
                 );

  emit filenameUrlChanged();

  return !m_Filename.isEmpty();
}

//----------------------------------------------------------------------------------------------
QUrl FileSaveDialog::filenameUrl() const
{
  return QUrl::fromLocalFile(m_Filename);
}
