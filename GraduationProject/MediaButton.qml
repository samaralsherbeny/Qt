import QtQuick
import QtQuick.Controls

Button {
    id: control

    property string iconSource: ""
    property int buttonSize: 64
    property int iconSize: 38

    width: buttonSize
    height: buttonSize

    background: Rectangle {
        anchors.fill: parent

        radius: width / 2

        color: control.pressed
               ? "#303B4D"
               : "#202938"

        border.color: "#46536A"
        border.width: 1
    }

    contentItem: Image {
        anchors.centerIn: parent

        width: control.iconSize
        height: control.iconSize

        source: control.iconSource

        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
