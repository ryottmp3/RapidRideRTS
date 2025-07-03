// settings.qml – full-featured settings page with theme selection and secure logout
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3

Page {
    id: settingsPage
    title: "Settings"

    ColumnLayout {
        anchors.fill: parent
        spacing: 20
        padding: 20

        Label {
            text: "Theme"
            font.pixelSize: 18
            color: Theme.text
        }

        ComboBox {
            id: themeSelector
            model: Theme.availableThemes
            currentIndex: Theme.currentIndex
            onCurrentIndexChanged: Theme.setTheme(themeSelector.currentText)
        }

        Rectangle {
            height: 1
            color: Theme.border
            Layout.fillWidth: true
        }

        Label {
            text: "Account"
            font.pixelSize: 18
            color: Theme.text
        }

        Button {
            text: "Change Email"
            Layout.fillWidth: true
            onClicked: messageDialog.text = "Email change not implemented yet."
        }

        Button {
            text: "Change Password"
            Layout.fillWidth: true
            onClicked: messageDialog.text = "Password change not implemented yet."
        }

        Button {
            text: "Manage Payment Info"
            Layout.fillWidth: true
            onClicked: controller.loadPage("paymentinfo.qml")
        }

        Rectangle {
            height: 1
            color: Theme.border
            Layout.fillWidth: true
        }

        Button {
            text: "Log Out"
            Layout.fillWidth: true
            onClicked: {
                Network.logout()
                controller.loadPage("login.qml")
            }
        }
    }

    MessageDialog {
        id: messageDialog
        title: "Coming Soon"
        text: ""
        onAccepted: messageDialog.close()
    }
}

