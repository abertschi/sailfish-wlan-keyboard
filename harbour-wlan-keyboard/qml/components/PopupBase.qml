import QtQuick 2.0
import Sailfish.Silica 1.0

MouseArea {
    id: popupBase
    anchors.bottom: parent.top
    width: parent.width
    height: placeHolder.height + 2 * Theme.paddingLarge

    property alias placeHolderContent: placeHolder.children
    property alias textLabel: textLabel

    property bool showImage: true
    property alias background: background

    onClicked: hide()

    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.highlightBackgroundColor
        z: -1
        opacity: 0.95
    }
    state: "invisible"

    states: [ State {
            name: "visible"
            AnchorChanges { target: popupBase; anchors.top: popupBase.parent.top; anchors.bottom: undefined }
        },

        State {
            name: "invisible"
            AnchorChanges { target: popupBase; anchors.bottom: popupBase.parent.top }
        }

    ]

    transitions: Transition {
        // smoothly reanchor myRect and move into new position
        AnchorAnimation { duration: 800; easing.type: Easing.OutExpo}
    }

    Item {
        id: placeHolder
        anchors.left: parent.left
        height: showImage ? 3* Theme.paddingLarge : 0
        width: height
        anchors.leftMargin: Theme.paddingLarge
        anchors.verticalCenter: parent.verticalCenter

        /*
        Rectangle {
            anchors.fill: parent
            color: "red"

        }

        */
    }

    Label {
        id: textLabel
        text: ""
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: placeHolder.right
        anchors.leftMargin: Theme.paddingLarge
        //font.bold: false
        font.pixelSize: Theme.fontSizeSmall
        color: "black"
    }

    Timer {
        id: hideTimer
        triggeredOnStart: false
        interval: 2000
        onTriggered: {
            hide()
            interval = 2000
        }
    }

    //Component.onCompleted: show("Port requires 4 digits")

    function _popupShow() {
        popupBase.state = "visible"
    }

    function _popupHide() {
        popupBase.state = "invisible"
    }

    function hide() {
        if (hideTimer.running)
            hideTimer.stop()
        if(waitingBullets.running)
            waitingBullets.stop()
        _popupHide()
    }

    function load(msg, time) {
        show(msg, time)
    }

    function show(msg, time) {
        if ((typeof(time) !== 'undefined') && (time !== null)) {
            hideTimer.interval = time
        }
        _popupShow()
        hideTimer.restart()
        textLabel.text = msg
    }
}
