// TransitHome.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    width: 480
    height: 800
    visible: true
    title: "RTS RapidRide"
    color: "#121212"

    signal viewPdfClicked()

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ToolBar {
            Layout.fillWidth: true
            contentHeight: 150
            background: Rectangle { color: "#1e1e1e" }

            Image {
                width: 400; height: 150
                source: "assets/rapidride.png"
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
            }
        }

        // 5 equally spaced buttons
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "View Routes"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("View Route")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: controller.loadPage("routes.qml")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Purchase Tickets"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Purchase Tickets")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Purchase Tickets... ")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Open Wallet"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Open Wallet")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Open Wallet... ")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "View Alerts"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("View Alerts")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("View Alerts... ")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Settings"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Settings")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Settings... ")
        }
    }
}

