
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 488
    title: "Task 2 App"

    SplashScreen {
        id: splashScreen
        anchors.fill: parent

        onFinished: {
            splashScreen.visible = false
            homeScreen.visible = true
        }
    }

    HomeScreen {
        id: homeScreen
        anchors.fill: parent
        visible: false
    }
}
