import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "widget"

ApplicationWindow
{
    initialPage: Component {
        NewHomePage { }
    }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    property int httpServerPort: 7778
    property int websocketServerPort: 7777;

    function startServers() {
        httpServer.startServer(httpServerPort);
        websocketServer.startServer(websocketServerPort);
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

