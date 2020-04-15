CONFIG += console
CONFIG += c++11
CONFIG += no_keywords

QT += opengl
QT += widgets

#GLEW
INCLUDEPATH += ../THIRD_PARTY/glew-2.1.0
LIBS += ../THIRD_PARTY/glew-2.1.0/LIB/libglew32.dll.a



SOURCES += \
    main.cpp \
    UI/volumeglrender.cpp \
    UI/volumeglrendereditdialog.cpp \
    UI/volumeglrenderformatdialog.cpp \
    UI/volumeglrenderbasecontroller.cpp

FORMS += \
    UI/volumeglrendereditdialog.ui \
    UI/volumeglrenderformatdialog.ui

HEADERS += \
    UI/volumeglrender.h \
    UI/volumeglrenderbasecontroller.h \
    UI/volumeglrendereditdialog.h \
    UI/volumeglrenderformatdialog.h \
    constants.h
