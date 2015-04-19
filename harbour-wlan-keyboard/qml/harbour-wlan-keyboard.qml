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
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

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

    Popup2 {
        id: popup
    }

    AppEvents {
        id: notifications
    }

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
        pageStack.push(Qt.resolvedUrl("PageHeadlessMode.qml"))
    }

    function openPageAbout() {
        pageStack.push(Qt.resolvedUrl("PageAbout.qml"))
    }

    function openPageClipboardMode() {
        pageStack.push(Qt.resolvedUrl("PageClipboardMode.qml"))
    }

    function getNotifications() {
        return notifications;
    }

    function getSettings() {
        return settings;
    }
}

