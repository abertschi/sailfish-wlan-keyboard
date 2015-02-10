#ifndef KEYBOARDPLUGIN_H
#define KEYBOARDPLUGIN_H

#include <QQmlExtensionPlugin>

class KeyboardPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    explicit KeyboardPlugin(QQuickItem *parent = 0);


signals:

public slots:

};

#endif // KEYBOARDPLUGIN_H
