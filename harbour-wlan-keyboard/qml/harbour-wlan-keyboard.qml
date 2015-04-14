import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "widget"
import "."

ApplicationWindow
{
    id: app

    initialPage: Component {
        HeadlessModePage { }
    }

    Component.onCompleted: {
        if (settings.autostart) {
            startServers()
        }
    }

    Settings {
        id: settings
    }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    function startServers() {
        var httpPort = settings.httpPort
        var wsPort = settings.wsPor;
        if (settings.useAnyConnection) {
            httpServer.startServerBroadcast(httpPort)
            websocketServer.startServerBroadcast(wsPort);
        } else {
            //attention: interface/ ip could change, check here first, if changed, pubish on any interface
            var interf = settings.connectionInterface
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

    function restartServers() {
            popup.load("Restarting server", 2000)
            app.stopServers()
            app.startServers()
    }

    Popup2 {
        id: popup
    }

}

