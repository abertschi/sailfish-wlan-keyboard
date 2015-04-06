import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "widget"
import "Settings.js" as Settings

ApplicationWindow
{
    id: app

    initialPage: Component {
        ContainerPage { }
    }

    Component.onCompleted: {
        Settings.init()
        if (Settings.isAutostart()) {
            startServers()
        }
    }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    function startServers() {
        var httpPort = Settings.getHttpPort();
        var wsPort = Settings.getWsPort();
        if (Settings.getUseAnyConnection()) {
            httpServer.startServer(httpPort);
            websocketServer.startServer(wsPort);
        } else {
            //attention: interface/ ip could change, check here first, if changed, pubish on any interface
            var interf = Settings.getPreferedIp();
            httpServer.startServer(interf, httpPort);
            websocketServer.startServer(interf, wsPort);
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

