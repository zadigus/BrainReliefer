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
void FileSaveDialog::createNewDataFile ()
{
  Data newData(QFileInfo(m_Filename).absoluteDir().absolutePath().toStdString()); // set RootDir

  Data::DataPath_sequence& pathSeq(newData.DataPath());
  pathSeq.push_back(DataPath("NewIntrants.xml",   N_Data::NEW_INTRANTS_ITEMS));
  pathSeq.push_back(DataPath("Incubation.xml",    N_Data::INCUBATION_ITEMS));
  pathSeq.push_back(DataPath("References.xml",    N_Data::REFERENCE_ITEMS));
  pathSeq.push_back(DataPath("Projects.xml",      N_Data::PROJECT_ITEMS));
  pathSeq.push_back(DataPath("NextActions.xml",   N_Data::NEXT_ACTIONS));
  pathSeq.push_back(DataPath("Agenda.xml",        N_Data::AGENDA_ITEMS));

  std::ofstream ofs(m_Filename.toStdString());
  Data_(ofs, newData);
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
