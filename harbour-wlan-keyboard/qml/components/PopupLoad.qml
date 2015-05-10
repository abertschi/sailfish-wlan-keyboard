import QtQuick 2.0
import Sailfish.Silica 1.0

PopupBase {

    Component.onCompleted: {

    }

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

    BusyIndicator {
        id: busyIndicator
        running: true
        color: Theme.primaryColor
        size: BusyIndicatorSize.Medium
        anchors.leftMargin: Theme.paddingLarge
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
}
