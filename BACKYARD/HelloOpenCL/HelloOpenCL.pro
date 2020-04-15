CONFIG += console   #For console output
CONFIG += c++11     #For vector initialization

#OpenCL
INCLUDEPATH += ..\..\THIRD_PARTY\OpenCL-1.2
LIBS += ..\..\THIRD_PARTY\OpenCL-1.2\LIB\libOpenCL.a

SOURCES += main.cpp
