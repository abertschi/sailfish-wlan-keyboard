import QtQuick 2.0
import Sailfish.Silica 1.0

DockedPanel {
    id: popup

    width: parent.width
    height: Theme.itemSizeExtraLarge + Theme.paddingLarge

    dock: Dock.Top
    open: true
    z: 99999

    Rectangle {
        anchors.fill: parent
        color: Theme.secondaryHighlightColor
    }

    Timer {
        id: hideTimer
        triggeredOnStart: false
        repeat: false
        interval: 4000
        onTriggered: popup.hide()
    }
    function hide() {
        if (hideTimer.running)
            hideTimer.stop()
            popup.open = !popup.open
    }
    function notify(msg) {
        hideTimer.restart()
        popup.open = !popup.open
        textLabel.text = msg
    }

    Row {
        anchors.fill: parent
        anchors.margins: {
            left: Theme.paddingLarge
            right: Theme.paddingLarge
        }

        width: parent.width
        spacing: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter


    ProgressCircle {
        id: progressCircle
        anchors.verticalCenter: parent.verticalCenter


        NumberAnimation on value {
            from: 0
            to: 1
            duration: 1000
            running: progressPanel.expanded
            loops: Animation.Infinite
        }
    }

    Label {
        id: textLabel
        text: "Server is restarting..."
        anchors.verticalCenter: parent.verticalCenter
        font.bold: false

    }
    }
}
