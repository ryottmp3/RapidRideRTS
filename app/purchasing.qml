// purchasing.qml – modern ticket purchasing page
// Integrates with Network.generateTicket() and listens for ticketGenerated signal.
// Expects the Network singleton and controller from main.py.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Item {
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1f1f1f" }
            GradientStop { position: 1.0; color: "#121212" }
        }
    }

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 24
        spacing: 20

        Label {
            text: qsTr("Purchase Ticket")
            font.pixelSize: 24
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }

        ComboBox {
            id: ticketTypeCombo
            Layout.fillWidth: true
            model: [
                { text: "Single Use", value: "single_use" },
                { text: "24-Hour Pass", value: "day_pass" },
                { text: "Monthly Pass", value: "monthly_pass" }
            ]
            textRole: "text"
            onActivated: {
                // optional: update description below
                description.text = model[index].text + qsTr(" selected")
            }
        }

        TextArea {
            id: description
            readOnly: true
            text: qsTr("Choose a ticket type above.")
            wrapMode: Text.WordWrap
            color: "#cccccc"
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            background: Rectangle { color: "transparent" }
        }

        Button {
            id: buyButton
            Layout.fillWidth: true
            height: 56
            text: qsTr("Buy Now")
            font.pixelSize: 18
            background: Rectangle {
                radius: 8
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#f5721b" }
                    GradientStop { position: 1.0; color: "#d55400" }
                }
            }
            contentItem: Text {
                text: buyButton.text
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 18
                font.bold: true
            }
            onClicked: {
                Network.generateTicket(ticketTypeCombo.model[ticketTypeCombo.currentIndex].value)
                busy.visible = true
            }
        }

        BusyIndicator {
            id: busy
            width: 32; height: 32
            visible: false
            running: visible
            Layout.alignment: Qt.AlignHCenter
        }
    }

    Connections {
        target: Network
        function onTicketGenerated(payload) {
            busy.visible = false
            // Optionally save payload or navigate to wallet
            controller.loadPage("wallet.qml")
        }
        function onErrorOccurred(err) {
            busy.visible = false
            description.text = qsTr("Error: ") + err
        }
    }
}
