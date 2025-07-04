// wallet.qml — Displays user tickets with QR code access
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Material 2.15

Rectangle {
    anchors.fill: parent
    color: Theme.background

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Label {
            text: "My Tickets"
            font.pixelSize: 24
            color: Theme.text
        }

        ListView {
            id: ticketList
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 12
            model: Network.ticketList  // Assumes this is a Q_PROPERTY list
            delegate: Rectangle {
                width: parent.width
                height: 100
                color: Theme.card
                radius: 10
                border.color: Theme.border
                border.width: 1
                anchors.margins: 8

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12

                    ColumnLayout {
                        spacing: 4
                        Label {
                            text: "Ticket ID: " + model.ticket_id
                            color: Theme.text
                            font.pixelSize: 14
                        }
                        Label {
                            text: model.ticket_type + " — " + model.issued_at
                            color: Theme.text
                            font.pixelSize: 12
                        }
                    }
                    Item { Layout.fillWidth: true }
                    Button {
                        text: "View QR"
                        onClicked: {
                            Network.loadQRCode(model.ticket_id)
                            qrDialog.open()
                        }
                    }
                }
            }
        }
    }

    Dialog {
        id: qrDialog
        modal: true
        standardButtons: Dialog.Ok
        title: "Your Ticket QR Code"
        contentItem: Image {
            source: Network.qrImage
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            anchors.margins: 16
        }
    }
}

