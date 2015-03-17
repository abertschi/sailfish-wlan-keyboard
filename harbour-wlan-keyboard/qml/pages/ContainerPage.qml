import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0
import "../widget"

Page {
    //https://github.com/lukedirtwalker/cutespotify/blob/sailfish/qml/FullControls.qml#L136
    id: page

    property int heightHeader: parent.height / 3
    property int heightNavi: Theme.paddingLarge *3
    property int heightTab: parent.height - heightNavi - heightHeader

    Item {
        id: powerSwitch
        width: parent.width
        height: heightHeader

        SilicaFlickable {
            anchors.fill: parent
            PullDownMenu {
                id: pullDownMenu
                MenuItem {
                    text: "Start server"
                    onClicked: console.log("Clicked option 1")
                }
            }

            MyActionButton {
                text: "Start server"
                iconSource: "image://theme/harbour-wlan-keyboard"
                //: console.log("pressend")
                width: parent.width
                height: parent.height
                anchors.fill: parent
            }
        }
    }

    SilicaListView {
        id: tabs
        anchors.top: powerSwitch.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: heightTab
        width: parent.width
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

    Item {
        id: navi
        height: heightNavi
        width: parent.width
        anchors {
            top: tabs.bottom
        }
        Row {
            Label {
                text: "todo: navi"
            }
        }

    }
}
