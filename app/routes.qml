// routes.qml – modern layout for route viewing
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Item {
    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1c1c1e" }
            GradientStop { position: 1.0; color: "#2c2c2e" }
        }

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
                    text: modelData.name
                    font.bold: true
                    font.pointSize: 16
                    background: Rectangle {
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#f5721b" }
                            GradientStop { position: 1.0; color: "#d55400" }
                        }
                    }
                    contentItem: Text {
                        text: modelData.name
                        anchors.centerIn: parent
                        color: "white"
                        font.pointSize: 18
                        font.bold: true
                    }
                    onClicked: backend.open_pdf_viewer(modelData.file)
                }
            }
        }
    }
}

