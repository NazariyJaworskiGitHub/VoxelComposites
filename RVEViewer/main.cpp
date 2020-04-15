#include <fstream>
#include <sstream>
#include <QApplication>
#include "UI/volumeglrender.h"
using namespace std;

int main(int argc, char *argv[])
{
    if(argc<2)
    {
        throw(std::runtime_error("No filename\n"));
        return -1;
    }

    int S;
    float rS;
    float *_RVE;
    std::string fileName(argv[1]);
    std::ifstream _RVEFileStream;
    try
    {
        _RVEFileStream.exceptions(std::ifstream::failbit | std::ifstream::badbit);
        _RVEFileStream.open(fileName, std::ios::in | std::ios::binary);
        if (_RVEFileStream.is_open())
        {
            _RVEFileStream.seekg(0, std::ios::beg);
            _RVEFileStream.read((char*)&S, sizeof(int));
            _RVEFileStream.read((char*)&rS, sizeof(float));
            _RVE = new float[S*S*S];
            try
            {
                _RVEFileStream.read((char*)_RVE, S*S*S*sizeof(float));
            }
            catch(std::exception &e)
            {
                delete [] _RVE;
                _RVEFileStream.close();
                throw(e);
            }
            _RVEFileStream.close();
        }
    }
    catch(std::exception &e)
    {
        if(_RVEFileStream.is_open())
            _RVEFileStream.close();
        std::stringstream _str;
        _str << e.what() << "\n";
        if(_RVEFileStream.fail() || _RVEFileStream.eof() || _RVEFileStream.bad())
            _str << "  failbit: " << _RVEFileStream.fail() <<"\n"
                 << "  eofbit: " << _RVEFileStream.eof() <<"\n"
                 << "  badbit: " << _RVEFileStream.bad() <<"\n";
        throw(std::runtime_error(_str.str()));
    }

    QApplication a(argc, argv);

    UserInterface::VolumeGLRender _render(S, _RVE, _RVE, NULL);
    _render.setBoundingBoxRepresentationSize(rS);
    _render.setInfoString(QString(fileName.data()));
    _render.resize(800,600);
    _render.show();

    return a.exec();
}

