// main.qml – centralized layout with persistent drawer and toolbar
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 720
    title: qsTr("RapidRide")

    // Shared gradient background
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0f0f0f" }
            GradientStop { position: 1.0; color: "#1a1a1a" }
        }
    }

    // Persistent drawer
    Drawer {
        id: navDrawer
        width: parent.width * 0.75
        height: parent.height
        edge: Qt.LeftEdge
        modal: true

        ColumnLayout {
            anchors.fill: parent
            spacing: 8

            Label {
                text: "Menu"
                font.pixelSize: 20
                font.bold: true
                color: "white"
            }

            Repeater {
                model: [
                    { label: "Home", page: "home.qml" },
                    { label: "Routes", page: "routes.qml" },
                    { label: "Purchase", page: "purchasing.qml" },
                    { label: "Wallet", page: "wallet.qml" },
                    { label: "Alerts", page: "alerts.qml" },
                    { label: "Settings", page: "settings.qml" },
                    { label: "Report Issue", page: "report.qml" },
                    { label: "Logout", page: "login.qml" }
                ]
                delegate: Button {
                    text: modelData.label
                    Layout.fillWidth: true
                    onClicked: {
                        navDrawer.close()
                        pageLoader.source = modelData.page
                    }
                }
            }
        }
    }

    // Top toolbar with hamburger and title
    ToolBar {
        id: topBar
        height: 50
        RowLayout {
            anchors.fill: parent
            spacing: 8

            ToolButton {
                text: "\u2261"
                font.pixelSize: 24
                onClicked: navDrawer.open()
            }

            Label {
                text: qsTr("RapidRide")
                font.pixelSize: 18
                Layout.alignment: Qt.AlignVCenter
                color: "white"
            }
        }
    }

    // Central loader to switch between screens
    Loader {
        id: pageLoader
        objectName: "pageLoader"
        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "home.qml"
    }

    onClosing: Qt.quit()
}

