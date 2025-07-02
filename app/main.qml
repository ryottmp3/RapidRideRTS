// main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    width: 480
    height: 800
    visible: true
    title: "RTS RapidRide"

    Loader {
        id: pageLoader
        objectName: "pageLoader"
        anchors.fill: parent
        source: "home.qml"
    }
    
    function loadPage(pageUrl) {
        pageLoader.source = pageUrl;
    }
}

