
#include <QQmlExtensionPlugin>
/*
class QExampleQmlPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:

    void registerTypes(const char *uri)
    {
        Q_ASSERT(uri == QLatin1String("TimeExample"));
        qmlRegisterType<TimeModel>(uri, 1, 0, "Time");
    }
};

class TimeModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int hour READ hour)
    Q_PROPERTY(int minute READ minute)

public:
    int hour() {return 44;}
    int minute() {return 34;}

}

*/
