import QtQuick 2.0
import Sailfish.Silica 1.0

import "pages"
import "components"
import "services"
import "cover"
import "."

ApplicationWindow
{
    id: app

    initialPage: Component {
        PageContainer { }
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

    Timer {
        id: startStopTimer
        property string text
        interval: 500
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            popup.load(text, 1500)
        }
    }

    function startServers() {
        startStopTimer.text = "Starting server ..."
        startStopTimer.start()
        var httpPort = settings.httpPort
        var wsPort = settings.wsPort;

        if (settings.useAnyConnection) {
            httpServer.startServerBroadcast(httpPort)
            websocketServer.startServerBroadcast(wsPort);
        } else {
            var interf = settings.connectionInterface
            httpServer.startServer(interf, httpPort);
            websocketServer.startServer(interf, wsPort);
        }
    }

    function stopServers() {
        startStopTimer.text = "Stopping server ..."
        startStopTimer.start()
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

    function openPageHeadlessMode() {

    }

    function openPageAbout() {

    }

    function openPageClipboardMode() {

    }

    Popup2 {
        id: popup
    }

    AppEvents {
        id: notifications
    }

}

