import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Rectangle {
    id: drawermain
    height: 800
    width: 1000

    Rectangle{
        id: chose
        color: "red"
        width: 200
        height: drawermain.height
        ColumnLayout{
            Button{
                text: "Test"
                onClicked: textzone.append("Button{ }")
            }
        }
    }
    Rectangle{
        id: table
        color: "blue"
        width: 800
        height: drawermain.height
        anchors.left: chose.right
        TextArea{
            id: textzone
            anchors.fill: parent
        }
    }
}

