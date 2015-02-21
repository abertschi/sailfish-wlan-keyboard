import QtQuick 2.0
import Sailfish.Silica 1.0

// based on tutorial by by http://sailfishdev.tumblr.com/page/2

MouseArea {
    id: popup
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width
    height: message.paintedHeight
    property alias title: message.text
    property alias timeout: hideTimer.interval
    property alias background: bg.color
    property alias interval: hideTimer.interval
    visible: opacity > 0
    opacity: 0.0
    Behavior on opacity {
        FadeAnimation {}
    }
    Rectangle {
        id: bg
        anchors.fill: parent
    }
    Timer {
        id: hideTimer
        triggeredOnStart: false
        repeat: false
        interval: 3000
        onTriggered: popup.hide()
    }
    function hide() {
        if (hideTimer.running)
            hideTimer.stop()
        popup.opacity = 0.0
    }
    function show() {
        popup.opacity = 1.0
        hideTimer.restart()
    }
    function notify(text, color) {
        popup.title = text
        if (color && (typeof(color) != "undefined"))
            bg.color = color
        else
            bg.color = Theme.rgba(Theme.highlightColor, 0.3)
        show()
    }
    Label {
        id: message
        anchors.verticalCenter: popup.verticalCenter
        font.pixelSize: Theme.fontSizeExtraSmall
        color:  Theme.rgba(Theme.secondaryHighlightColor, 0.8 )
        anchors.left: parent.left
        anchors.leftMargin: Theme.paddingLarge
        anchors.right: parent.right
        anchors.rightMargin: Theme.paddingRight
        wrapMode: Text.Wrap
    }
    onClicked: hide()
}