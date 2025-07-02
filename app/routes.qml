// TransitHome.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Rectangle {
    anchors.fill: parent
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
                text: qsTr("Borglum Route")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: backend.open_pdf_viewer("borglum")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Purchase Tickets"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Coolidge Route")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Coolidge... ")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Open Wallet"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Jefferson Route")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Jefferson... ")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "View Alerts"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Lincoln Route")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Lincoln... ")
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Settings"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Roosevelt Route")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Roosevelt... ")
        }
        
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Settings"
            font.pixelSize: 20
            background: Rectangle { color: "#1f1f1f" }
            contentItem: Text {
                text: qsTr("Washington Route")
                color: "#ffffff"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            onClicked: console.log("Washington... ")
        }
    }
}

