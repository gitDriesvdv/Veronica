import QtQuick 2.0
import QtQuick 2.1
import Enginio 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1

Rectangle{
    height: 800
    width: 1000
    anchors.fill: parent

    EnginioClient {
        id: enginioClient
        backendId: "54be545ae5bde551410243c3"
        onError: {
            enginioModelErrors.append({"Error": "Enginio " + reply.errorCode + ": " + reply.errorString + "\n\n", "User": "Admin"})
            console.debug(JSON.stringify(reply.data))
        }
    }
    EnginioModel {
        id: enginioModelErrors
        client: client
        query: {
            "objectType": "objects.Errors"
        }
    }
    TabView {
        height: 800
        width: 1000
        Tab {
            title: "Errors"
            Rectangle{
                id: errorlist
                height: 400
                width: 1000

            ColumnLayout {


            anchors.margins: 3
            spacing: 3
            height: 400
            width: 1000
            TableView {
                id: errorview
                Layout.fillWidth: true
                Layout.fillHeight: true
                // resizeColumnsToContents()

                TableViewColumn { title: "Date"; role: "createdAt" }
                TableViewColumn { title: "User"; role: "User" }
                TableViewColumn { title: "Error"; role: "Error" }

                model: EnginioModel {
                    id: enginioModel
                    client: enginioClient
                    query: {"objectType": "objects.Errors",
                            "query" : { "Solved": false} }
                }
                onClicked: {
                    console.log( errorview.model.get(errorview.currentRow).Error);
                }
            }

            Button {
                id: refreshbutton
                text: "Refresh"
                Layout.fillWidth: true

                onClicked: {
                    var tmp = enginioModel.query
                    enginioModel.query = null
                    enginioModel.query = tmp
                }
            }
            Button{
                text: "Solved"
                anchors.top: refreshbutton.bottom
                Layout.fillWidth: true
                onClicked: {
                          enginioModel.setProperty(errorview.currentRow, "Solved", "true")
                          reload()
                         // errorview.update();
                }
            }
        }
            }
        }
        Tab {
            title: "Solved"
            Rectangle{
                id: errorlistSolved
                height: 400
                width: 1000

            ColumnLayout {


            anchors.margins: 3
            spacing: 3
            height: 400
            width: 1000
            TableView {
                id: errorviewSolved
                Layout.fillWidth: true
                Layout.fillHeight: true

                TableViewColumn { title: "Date"; role: "createdAt" }
                TableViewColumn { title: "User"; role: "User" }
                TableViewColumn { title: "Error"; role: "Error" }

                model: EnginioModel {
                    id: enginioModelSolved
                    client: enginioClient
                    query: {"objectType": "objects.Errors",
                            "query" : { "Solved": true}}
                }
            }

            Button {
                id: refreshbuttonSolved
                text: "Refresh"
                Layout.fillWidth: true

                onClicked: {
                    var tmp = enginioModelSolved.query
                    enginioModelSolved.query = null
                    enginioModelSolved.query = tmp
                }
            }
            Button{
                text: "remove"
                anchors.top: refreshbuttonSolved.bottom
                Layout.fillWidth: true
                onClicked: {
                    enginioModelSolved.remove(errorviewSolved.currentRow)
                }
            }
        }
            }
        }

    }
   function reload()
   {
       var tmp = enginioModel.query
       enginioModel.query = null
       enginioModel.query = tmp
   }
}

