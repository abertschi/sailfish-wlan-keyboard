import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Image {
        id: image
        y: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.5
        source: "image://theme/harbour-wlan-keyboard"
    }

    Label {
        id: label
        anchors.centerIn: parent
        color: Theme.secondaryColor
        width: parent.width - 2*Theme.paddingLarge
        height: width
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        font.pixelSize: Theme.fontSizeExtraSmall

        text: qsTr("Not running")

        Connections {
            target: httpServer

            onRunningChanged: {
                if(isRunning) {
                    label.text = qsTr("Running at") + " <br/><b>" + extractHttpPrefix(httpServer.getFullAddress()) + "</b>"
                }
                else {
                   label.text = qsTr("Not running")
                }
            }
        }
    }

    function extractHttpPrefix(addr) {
        if(addr != 'undefined' && addr.length > 1) {
            return addr.substr(7, addr.length);
        }
        return addr;
    }
}


