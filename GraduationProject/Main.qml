import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root

    width: 1280
    height: 720
    visible: true

    title: "Media Player IVI"
    color: "#10141C"

    StackView {
        id: stackView

        anchors.fill: parent

        initialItem: homePage
    }

    Component {
        id: homePage

        HomePage {
            stack: stackView
        }
    }
}
