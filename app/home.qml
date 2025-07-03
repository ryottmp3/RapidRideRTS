// home.qml – content‑only page (App shell handles navigation)
// This page shows big action buttons and relies on main.qml for the top bar & drawer.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    anchors.fill: parent

    // subtle vertical gradient
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#1f1f1f" }
        GradientStop { position: 1.0; color: "#121212" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        // big menu buttons (labels + controller navigation)
        Repeater {
            model: [
                { label: "View Routes",       page: "routes.qml"       },
                { label: "Purchase Tickets", page: "purchasing.qml"   },
                { label: "Open Wallet",      page: "wallet.qml"       },
                { label: "View Alerts",      page: "alerts.qml"       },
                { label: "Settings",         page: "settings.qml"     }
            ]

            delegate: Button {
                Layout.fillWidth: true
                height: 60
                text: modelData.label
                font.pixelSize: 18

                background: Rectangle {
                    color: "#292929"
                    radius: 8
                    border.color: "#f5721b"
                    border.width: 1
                }

                contentItem: Text {
                    text: modelData.label
                    color: "white"
                    font.pixelSize: 18
                    anchors.centerIn: parent
                }

                onClicked: controller.loadPage(modelData.page)
            }
        }
    }
}

