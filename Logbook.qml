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
        id: enginioClientLog
        backendId: "54be545ae5bde551410243c3"
        onError: {
        console.debug(JSON.stringify(reply.data))
        enginioModelErrors.append({"Error": "Enginio" + reply.errorCode + ": " + reply.errorString + "\n\n", "User": "Admin"})
        }
    }
    EnginioModel {
        id: enginioModelErrors
        client: enginioClientLog
        query: {
            "objectType": "objects.Errors"
        }
    }
    Rectangle{
        id: logbooklist
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
        TableViewColumn { title: "Log"; role: "Log" }

        model: EnginioModel {
            id: enginioModel
            client: enginioClientLog
            query: {"objectType": "objects.Logbook" }
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
    Rectangle{
        id : addLog
        anchors.top: logbooklist.bottom

        /*MessageDialog {
            id: messageDialog
            title: "Message"
        }*/
ColumnLayout {
    anchors.margins: 3
    spacing: 3

    TextArea {
        id: log
        Layout.fillWidth: true
        //placeholderText: "Log"
    }



    Button {
        id: proccessButton
        Layout.fillWidth: true
        enabled: log.text.length
        text: "LOG"

        states: [
            State {
                name: "Logging"
                PropertyChanges {
                    target: proccessButton
                    text: "Logging..."
                    enabled: false
                }
            }
        ]

        onClicked: {
            proccessButton.state = "Logging"
            //![create]
            var reply = enginioClientLog.create(
                        { objectType: "objects.Logbook",
                          "Log": log.text,
                          "User" : "Admin"
                        })

            reply.finished.connect(function() {

                    proccessButton.state = ""
                    if (reply.errorType !== EnginioReply.NoError) {
                        //messageDialog.text = "Failed to create an account:\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
                        //enginioModelErrors.append({"Error": login.text + " Failed to create an account:\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n", "User": "Admin"})
                    } else {
                        /*messageDialog.text = "Account Created.\n"
                        enginioModelLogs.append({"Log": login.text + " Account Created", "User": "Admin"})
                        login.text = ""
                        password.text = ""
                        userEmail.text = ""
                        userFirstName.text = ""*/
                        log.text = ""
                    }
                    //messageDialog.visible = true;
                })
        }
    }

}

}
}



