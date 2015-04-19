import QtQuick 2.0
import Sailfish.Silica 1.0

MouseArea {
    id: popup
    anchors.bottom: parent.top
    width: parent.width
    height:busyIndicator.height + 2 * Theme.paddingLarge

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
            AnchorChanges { target: popup; anchors.top: popup.parent.top; anchors.bottom: undefined }
        },

        State {
            name: "invisible"
            AnchorChanges { target: popup; anchors.bottom: popup.parent.top }
        }

    ]

    Timer {
        id: waitingBullets
        property int count: 0
        repeat: true
        running: false
        interval: 400
        onTriggered: {
            if (count == 3) {
                ///var len = textLabel.text.length
                //textLabel.text = textLabel.text.substring(0 , len -4);
                count = 0
            }
            else {
                if (count == 0) {
                    //textLabel.text += " "
                }
                //textLabel.text += "."
                //count ++
            }
        }
    }

    transitions: Transition {
        // smoothly reanchor myRect and move into new position
        AnchorAnimation { duration: 800; easing.type: Easing.OutExpo}
    }

    BusyIndicator {

        id: busyIndicator
        running: true
        color: Theme.primaryColor
        size: BusyIndicatorSize.Medium
        anchors.left: parent.left
        anchors.leftMargin: Theme.paddingLarge
        anchors.verticalCenter: parent.verticalCenter
    }

    Label {
        id: textLabel
        text: ""
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: busyIndicator.right
        anchors.leftMargin: Theme.paddingLarge
        //font.bold: false
        font.pixelSize: Theme.fontSizeSmall
        color: "black"
    }

    Timer {
        id: hideTimer
        triggeredOnStart: false
        repeat: false
        interval: 2000
        onTriggered: {
            hide()
            interval = 2000
        }
    }

    function _popupShow() {
        popup.state = "visible"
    }

    function _popupHide() {
        popup.state = "invisible"
    }

    function hide() {
        if (hideTimer.running)
            hideTimer.stop()
        if(waitingBullets.running)
            waitingBullets.stop()
        _popupHide()
    }

    function load(msg, time) {
        if(time != 'undefined' && time != null) {
            hideTimer.interval = time
        }
        _popupShow()
        waitingBullets.restart()
        hideTimer.restart()

        textLabel.text = msg
    }
}
