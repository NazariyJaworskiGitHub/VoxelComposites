CONFIG += console
CONFIG += c++11
CONFIG += no_keywords

QT += testlib
QT += opengl
QT += widgets

#Qt containers usage
#DEFINES += _USE_QT_CONTAINERS

#GLEW
#<http://glew.sourceforge.net/index.html> and <http://www.grhmedia.com/glew.html>
INCLUDEPATH += ..\THIRD_PARTY\glew-2.1.0
LIBS += ..\THIRD_PARTY\glew-2.1.0\LIB\libglew32.dll.a

#Warning!!! this section is the including of FEM branch,
#remake project tree to avoid this section!!!
#Warning! - can't compile Eigen 3.2.0 and (GLEW + OpenCL) see https://bugreports.qt.io/browse/QTBUG-38312
INCLUDEPATH += ..\THIRD_PARTY\Eigen-3.2.0
INCLUDEPATH += ..\MathUtils

#OpenCL
INCLUDEPATH += ..\THIRD_PARTY\OpenCL-1.2
LIBS += ..\THIRD_PARTY\OpenCL-1.2\LIB\libOpenCL.a

#ViennaCL
#delete CL folder from ViennaCL
DEFINES += VIENNACL_WITH_OPENCL
INCLUDEPATH += ..\THIRD_PARTY\ViennaCL-1.7.1

#For debugging
CONFIG(debug, release|debug):DEFINES += _DEBUG_MODE

#For dr.memory debug
#QMAKE_CXXFLAGS_DEBUG += -ggdb

#Optimisation flags
#see https://gcc.gnu.org/onlinedocs/gcc-4.9.2/gcc/Optimize-Options.html#Optimize-Options
#    except -ftree-loop-vectorize for -O3 level (at least, not supportet in MinGW 4.8.0)
#Note, -fipa-cp-clone if disabled, because it causes the fail at MathUtils::
#    calculateCircumSphereCenterByCayleyMengerDeterminant::Eigen::DynamicMatrix::lu().solve
#    at least under MinGW 4.8.0 and Eigen 3.2.0
#QMAKE_CXXFLAGS_RELEASE -= -O0
QMAKE_CXXFLAGS_RELEASE -= -O1
QMAKE_CXXFLAGS_RELEASE -= -O2
QMAKE_CXXFLAGS_RELEASE *= -O3
#QMAKE_CXXFLAGS_RELEASE += -O2 \ #Equivalent to -O3 (MinGW 4.8.0)
#    -finline-functions \        #includes all, except -fipa-cp-clone
#    -funswitch-loops \
#    -frename-registers \
#    -fpredictive-commoning \
#    -fgcse-after-reload \
#    -ftree-slp-vectorize \
#    -fvect-cost-model \
#    -ftree-partial-pre

#QMAKE_CXXFLAGS_DEBUG -= -O1
##QMAKE_CXXFLAGS_DEBUG -= -O2
##QMAKE_CXXFLAGS_DEBUG *= -O3
#QMAKE_CXXFLAGS_DEBUG += -O2 \   #Equivalent to -O3 (MinGW 4.8.0)
#    -finline-functions \        #includes all, except -fipa-cp-clone
#    -funswitch-loops \
#    -frename-registers \
#    -fpredictive-commoning \
#    -fgcse-after-reload \
#    -ftree-slp-vectorize \
#    -fvect-cost-model \
#    -ftree-partial-pre

SOURCES += main.cpp \
    CLMANAGER/clmanager.cpp \
    TESTS/test_clmanager.cpp \
    UI/volumeglrender.cpp \
    representativevolumeelement.cpp \
    TESTS/test_viennacl.cpp \
    simulation.cpp \
    TESTS/test_simulation.cpp \
    CONSOLE/consolecommand.cpp \
    UI/volumeglrenderformatdialog.cpp \
    UI/clmanagergui.cpp \
    UI/userinterfacemanager.cpp \
    LOGGER/logger.cpp \
    UI/volumeglrenderbasecontroller.cpp \
    UI/volumeglrenderrve.cpp \
    UI/volumeglrenderrveeditdialog.cpp \
    UI/filterpreviewglrender.cpp \
    UI/volumeglrendereditdialog.cpp \
    CONSOLE/representativevolumeelementconsoleinterface.cpp \
    UI/xyglrender.cpp \
    UI/xyglrenderformatdialog.cpp \
    UI/inclusionpreviewglrender.cpp \
    UI/curvepreviewglrender.cpp \
    TESTS/test_matrix.cpp \
    TESTS/test_derivative.cpp \
    TESTS/test_polynomial.cpp \
    TESTS/test_fespacesimplex.cpp \
    TESTS/test_problem.cpp \
    TESTS/test_domain.cpp \
    TESTS/test_synthesis.cpp

HEADERS += \
    CLMANAGER/clmanager.h \
    TESTS/tests_runner.h \
    TESTS/test_clmanager.h \
    UI/volumeglrender.h \
    representativevolumeelement.h \
    TESTS/test_viennacl.h \
    simulation.h \
    TESTS/test_simulation.h \
    CONSOLE/console.h \
    CONSOLE/consolecommand.h \
    UI/volumeglrenderformatdialog.h \
    CONSOLE/consolerunner.h \
    CONSOLE/clmanagerconsoleinterface.h \
    CONSOLE/representativevolumeelementconsoleinterface.h \
    CLMANAGER/viennaclmanager.h \
    UI/clmanagergui.h \
    UI/userinterfacemanager.h \
    LOGGER/logger.h \
    LOGGER/loggerprivate.h \
    UI/volumeglrenderbasecontroller.h \
    UI/volumeglrenderrve.h \
    UI/volumeglrenderrveeditdialog.h \
    UI/filterpreviewglrender.h \
    UI/volumeglrendereditdialog.h \
    UI/xyglrender.h \
    UI/xyglrenderformatdialog.h \
    constants.h \
    UI/inclusionpreviewglrender.h \
    UI/curvepreviewglrender.h \
    timer.h \
    matrix.h \
    TESTS/test_matrix.h \
    FEM/weakoperator.h \
    FEM/derivative.h \
    TESTS/test_derivative.h \
    FEM/polynomial.h \
    TESTS/test_polynomial.h \
    FEM/fespacesimplex.h \
    FEM/jacobimatrix.h \
    TESTS/test_fespacesimplex.h \
    FEM/domain.h \
    FEM/problem.h \
    FEM/staticconstants.h \
    TESTS/test_problem.h \
    TESTS/test_domain.h \
    SYNTHESIS/synthesis.h \
    TESTS/test_synthesis.h \
    _SIMULATIONS/al_sic.h \
    _SIMULATIONS/mechanical.h \
    _SIMULATIONS/aao.h \
    _SIMULATIONS/porouswall.h

FORMS += \
    UI/volumeglrenderformatdialog.ui \
    UI/clmanagergui.ui \
    UI/volumeglrenderrveeditdialog.ui \
    UI/volumeglrendereditdialog.ui \
    UI/xyglrenderformatdialog.ui
