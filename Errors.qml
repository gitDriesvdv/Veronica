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
    Rectangle{
        id: userlist
        height: 400
        width: 800

    ColumnLayout {


    anchors.margins: 3
    spacing: 3
    height: 400
    width: 800
    TableView {
        Layout.fillWidth: true
        Layout.fillHeight: true

        TableViewColumn { title: "Date"; role: "createdAt" }
        TableViewColumn { title: "User"; role: "User" }
        TableViewColumn { title: "Error"; role: "Error" }

        model: EnginioModel {
            id: enginioModel
            client: enginioClient
            query: {"objectType": "objects.Errors" }
        }
    }

    Button {
        text: "Refresh"
        Layout.fillWidth: true

        onClicked: {
            var tmp = enginioModel.query
            enginioModel.query = null
            enginioModel.query = tmp
        }
    }
}
    }
}

