import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Enginio 1.0
import QtQuick.Controls.Styles 1.2

ApplicationWindow {
    title: qsTr("Veronica")
    height: 800
    width: 1400
    visible: true
    color: "white"

    Label {
                        id: label
                        text: "Loading Veronica..."
                        font.pixelSize: 28
                        color: "black"
                        anchors.centerIn: parent
                        visible: view.status != TabView.Ready
                    }

    Row {
        Column {
            Repeater {
                model: view.count
                Rectangle {
                    width: Screen.width/5
                    height: 70
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: view.getTab(index).title
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: view.currentIndex = index
                    }
                }
            }
        }
        TabView {
            id: view
            width: Screen.width
            height: Screen.height
            style: TabViewStyle {
                tab: Rectangle {
                    color: "transparent"
                    border.color:  "steelblue"
                    radius: 2
                }
            }
            Tab {
                title: "Users"
                Users { anchors.fill: parent }
            }
            Tab {
                title: "Errors"
                Errors { anchors.fill: parent }
            }
            Tab {
                title: "Logs"
                Logs { anchors.fill: parent }
            }
            Tab {
                title: "Components"
                Components { anchors.fill: parent }
            }
            Tab {
                title: "Logbook"
                Logbook { anchors.fill: parent }
            }
        }
    }
}
