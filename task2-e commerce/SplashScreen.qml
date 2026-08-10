import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: splashScreen
    anchors.fill: parent
    color: "#0f0f0f"

    signal finished()

    readonly property string basePath: "file:///home/samar/task2/build/Desktop_Qt_6_11_1_Debug/"

    Column {
        anchors.centerIn: parent
        spacing: 15

        // App Logo
        Image {
            source: splashScreen.basePath + "logo.png"
            width: 140
            height: 140
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "S MOTORS"
            color: "#f39c12"
            font.pixelSize: 28
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: false
        onTriggered: splashScreen.finished()
    }
}
