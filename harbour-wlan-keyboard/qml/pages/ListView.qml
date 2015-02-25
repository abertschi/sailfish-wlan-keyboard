import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Page {
    //https://github.com/lukedirtwalker/cutespotify/blob/sailfish/qml/FullControls.qml#L136
    SilicaListView {
        id: list
        anchors.fill: parent;
        boundsBehavior: Flickable.StopAtBounds
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        //highlightRangeMode: ListView.StrictlyEnforceRange
        cacheBuffer: width * 2
        //highlightMoveDuration: 0
        //clip: true
        pressDelay: 300



        highlightFollowsCurrentItem: true
        model: visualModel

    }
    VisualDataModel {
        id: visualModel
        model: ListModel {
            ListElement { name: "Apple" }
            ListElement { name: "Orange" }
        }
        delegate: Rectangle {
            width: list.width
            height: list.height
            Text { text: "Name: " + name}
        }
    }
}
