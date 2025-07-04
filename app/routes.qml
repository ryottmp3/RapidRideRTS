// routes.qml – theme-aware layout for route viewing
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Item {
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: Theme.background

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 16

            Repeater {
                model: [
                    { name: "Borglum Route", file: "borglum" },
                    { name: "Coolidge Route", file: "coolidge" },
                    { name: "Jefferson Route", file: "jefferson" },
                    { name: "Lincoln Route", file: "lincoln" },
                    { name: "Roosevelt Route", file: "roosevelt" },
                    { name: "Washington Route", file: "washington" }
                ]

                delegate: Button {
                    Layout.fillWidth: true
                    height: 60
                    font.pointSize: 16
                    font.bold: true
                    text: modelData.name

                    background: Rectangle {
                        color: Theme.buttonBackground
                        radius: 10
                        border.color: Theme.accent
                        border.width: 1
                    }

                    contentItem: Text {
                        text: modelData.name
                        anchors.centerIn: parent
                        color: Theme.buttonText
                        font.pointSize: 18
                        font.bold: true
                    }

                    onClicked: backend.open_pdf_viewer(modelData.file)
                }
            }
        }
    }
}

