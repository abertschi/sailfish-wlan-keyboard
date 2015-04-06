import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "widget"
import "Settings.js" as Settings
import "."

ApplicationWindow
{
    id: app

    initialPage: Component {
        ContainerPage { }
    }

    Component.onCompleted: {
        if (settings.autostart) {
            //startServers()
        }
    }

    Settings {
        id: settings
    }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    function startServers() {
        var httpPort = settings.httpPort
        var wsPort = settings.wsPor;
        if (Settings.getUseAnyConnection()) {
            httpServer.startServer(httpPort);
            websocketServer.startServer(wsPort);
        } else {
            //attention: interface/ ip could change, check here first, if changed, pubish on any interface
            var interf = settings.prefferedIp
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

