TEMPLATE = app
TARGET = vokoscreen

# Input
HEADERS += screencast.h \
           regionselection.h \
           QvkLupe.h \
           QvkWebcam.h \
           QvkWinInfo.h \
           
SOURCES += main.cpp \
           screencast.cpp \
           regionselection.cpp \
           QvkLupe.cpp \
           QvkWebcam.cpp \
           QvkWinInfo.cpp \

RESOURCES += screencast.qrc
                        
TRANSLATIONS = $$files(language/vokoscreen_*.ts)
                
# language packages
!isEmpty(TRANSLATIONS) 
{
  isEmpty(QMAKE_LRELEASE)
  {
    win32:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]\lrelease.exe
      else:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease
  }
  isEmpty(TS_DIR):TS_DIR = language
  TSQM.name = lrelease ${QMAKE_FILE_IN}
  TSQM.input = TRANSLATIONS
  TSQM.output = $$TS_DIR/${QMAKE_FILE_BASE}.qm
  TSQM.commands = $$QMAKE_LRELEASE ${QMAKE_FILE_IN}
  TSQM.CONFIG = no_link
  QMAKE_EXTRA_COMPILERS += TSQM
  PRE_TARGETDEPS += compiler_TSQM_make_all
}
else:message(No translation files in project)


# Install paths
image.path = /usr/share/pixmaps
image.files += applications/vokoscreen.png
desktop.path = /usr/share/applications
desktop.files += applications/vokoscreen.desktop
man.path = /usr/share
man.files += man
target.path = /usr/bin

INSTALLS += target image desktop man

# Clean target
QMAKE_CLEAN += $$TARGET

# QtSingleApplication
include(QtSingleApplication/qtsingleapplication.pri)

# libqxt
include(libqxt/libqxt.pri)

# audio
include(audio/audio.pri)

# send
include(send/send.pri)

#include(QtZip-src/QtZip.pri)
# -lz wird benötigt für QtZip, dies benötigt libz.so
#LIBS += -lz

CONFIG  += qtestlib
#system( ls )

LIBS += -lasound

