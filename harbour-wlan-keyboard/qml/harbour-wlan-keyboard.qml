import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "widget"

ApplicationWindow
{
    id: app

    //property alias utils: utils

    initialPage: Component {
        ContainerPage { }
    }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    QtObject {
        id: settings
        property int httpPort: 7778
        property int wsPort: 7777;
        property bool anyInterface: true
        property string interfaceAddr
        property bool isStartedOnLaunch: false
        property bool useHttps: false

    }

    function startServers() {
        if (settings.anyInterface) {
            httpServer.startServer(settings.httpPort);
            websocketServer.startServer(settings.wsPort);
        } else {
            httpServer.startServer(interfaceAddr, settings.httpPort);
            websocketServer.startServer(interfaceAddr, settings.wsPort);
        }
    }

    function stopServers() {
        httpServer.stopServer();
        websocketServer.stopServer();
    }

    function isServerRunning() {
        return httpServer.isRunning() && websocketServer.isRunning();
    }

    Popup {
        id: popup
    }
}

