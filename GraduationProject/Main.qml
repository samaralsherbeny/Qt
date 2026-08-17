import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root

    width: 1280
    height: 720

    visible: true

    title: "Media Player IVI"

    color: "#0D121B"


    StackView {
        id: stackView

        anchors.fill: parent

        initialItem: splashScreen
    }


    Component {
        id: splashScreen

        SplashScreen {
            stack: stackView
        }
    }
}
