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
            id: flick
            anchors.fill: parent
            PullDownMenu {
                id: powerSwitchPullDown

                MenuItem {
                    id: about
                    text: "About"
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("About.qml"))
                    }
                }

                MenuItem {
                    id: start
                    text: "Start server"
                    visible: true
                    onClicked: {
                        console.log("clicked");
                        app.startServers();
                        visible = false;
                        stop.visible = true;
                    }
                }
                MenuItem {
                    id: stop
                    text: "Stop server"
                    visible: false
                    onClicked: {
                        app.stopServers();
                        visible = false;
                        start.visible = true;
                    }
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
        keyNavigationWraps: true

        NumberAnimation { target: parent; property: "contentX"; duration: 1000; easing.type: Easing.InOutQuad }

        onContentXChanged: {
            console.log("changed")
        }

        highlightFollowsCurrentItem: true

        VerticalScrollDecorator{}

        model: VisualItemModel {
            RuntimeTab { id: runtimeTab }
            ConfigTab { id: configTab }

        }
    }

    Item {
        anchors.left: parent.left
        anchors.right: parent.right

        height: heightNavi
        width: parent.width
        anchors {
            top: tabs.bottom
        }

        Rectangle {
            id: marker
            color: Theme.highlightBackgroundColor
            width: parent.width / naviRepeater.count
            x: tabs.currentIndex * width
            height: 5
            anchors.bottom: naviRow.top
            opacity: 0.5

            Behavior on x {
                NumberAnimation {
                    duration:  100
                }
            }
        }

        Row {
            width: parent.width
            height: parent.height
            id: naviRow

            Repeater {
                id: naviRepeater
                model: [qsTr("Runtime"), qsTr("Configuration")]

                Item {
                    id: naviItem
                    height: parent.height
                    width: naviRow.width / naviRepeater.count
                    property int ind: index
                    Component.onCompleted: console.log(parent.count)

                    Label {
                        text: modelData
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeExtraSmall
                        font.bold: true
                        color: Theme.secondaryColor
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (tabs.currentIndex != parent.ind)
                                tabs.incrementCurrentIndex()

                        }
                    }
                }
            }
        }
    }
}
