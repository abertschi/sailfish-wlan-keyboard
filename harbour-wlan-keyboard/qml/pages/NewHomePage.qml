import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Page {
    //https://github.com/lukedirtwalker/cutespotify/blob/sailfish/qml/FullControls.qml#L136
    id: page

    Item {
        id: powerSwitch
        width: parent.width - 2* Theme.paddingLarge
        height: parent.height / 3

        IconButton {
            anchors.centerIn: parent
            width: parent.width / 2

        }


        Column {

            Label {
                text: "Start server"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Image {
                source: "image://theme/harbour-wlan-keyboard"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

    }


    SilicaListView {
        id: tabs
        anchors.fill: parent;
        boundsBehavior: Flickable.StopAtBounds
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        cacheBuffer: width * 2
        highlightMoveDuration: 0
        clip: true
        pressDelay: 300

        highlightFollowsCurrentItem: true

        model: VisualItemModel {
            RuntimeTab { id: runtimeTab }
            ConfigTab { id: configTab }
        }
    }
}
