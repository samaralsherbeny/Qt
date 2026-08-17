import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: splashScreen

    property StackView stack
    property int progress: 0

    background: Rectangle {
        color: "#0D121B"
    }

    // =====================================
    // MAIN SPLASH CONTAINER
    // =====================================

    Rectangle {
        anchors.centerIn: parent

        width: Math.min(parent.width * 0.75, 900)
        height: Math.min(parent.height * 0.70, 500)

        radius: 20

        color: "#151D29"

        border.color: "#2B374A"
        border.width: 1


        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 50

            spacing: 20


            // =====================================
            // LOGO
            // =====================================

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.minimumHeight: 180


                // Outer circle
                Rectangle {
                    id: logoCircle

                    anchors.centerIn: parent

                    width: 150
                    height: 150

                    radius: width / 2

                    color: "#30203A"

                    border.color: "#C957D9"
                    border.width: 3


                    // Inner circle
                    Rectangle {

                        anchors.centerIn: parent

                        width: 115
                        height: 115

                        radius: width / 2

                        color: "#0D121B"

                        border.color: "#C957D9"
                        border.width: 2


                        // Play symbol
                        Text {

                            anchors.centerIn: parent

                            text: "▶"

                            color: "#C957D9"

                            font.pixelSize: 48
                            font.bold: true

                            anchors.horizontalCenterOffset: 4
                        }
                    }


                    // Rotating ring
                    Rectangle {

                        anchors.centerIn: parent

                        width: 165
                        height: 165

                        radius: width / 2

                        color: "transparent"

                        border.color: "#C957D9"
                        border.width: 2

                        opacity: 0.5

                        RotationAnimation on rotation {

                            from: 0
                            to: 360

                            duration: 1800

                            loops: Animation.Infinite
                        }
                    }
                }
            }


            // =====================================
            // TITLE
            // =====================================

            Label {

                text: "Media Player IVI"

                color: "white"

                font.pixelSize: 38
                font.bold: true

                Layout.alignment: Qt.AlignHCenter
            }


            // =====================================
            // SUBTITLE
            // =====================================

            Label {

                text: "Smart In-Vehicle Media System"

                color: "#9AA8BD"

                font.pixelSize: 16

                Layout.alignment: Qt.AlignHCenter
            }


            // =====================================
            // LOADING TEXT
            // =====================================

            Label {

                id: loadingText

                text: "Loading..."

                color: "#C957D9"

                font.pixelSize: 15
                font.bold: true

                Layout.alignment: Qt.AlignHCenter
            }


            // =====================================
            // PROGRESS BAR
            // =====================================

            Rectangle {

                Layout.fillWidth: true

                Layout.preferredHeight: 8

                Layout.maximumWidth: 500

                radius: 4

                color: "#263247"

                Layout.alignment: Qt.AlignHCenter


                Rectangle {

                    width: parent.width * (splashScreen.progress / 100)

                    height: parent.height

                    radius: 4

                    color: "#C957D9"


                    Behavior on width {

                        NumberAnimation {
                            duration: 150
                        }
                    }
                }
            }


            // =====================================
            // PERCENTAGE
            // =====================================

            Label {

                text: splashScreen.progress + "%"

                color: "#8D9AAF"

                font.pixelSize: 13

                Layout.alignment: Qt.AlignHCenter
            }
        }
    }


    // =====================================
    // LOADING TIMER
    // =====================================

    Timer {

        id: loadingTimer

        interval: 40

        repeat: true

        running: true

        onTriggered: {

            if (splashScreen.progress < 100) {

                splashScreen.progress += 1

            }
            else {

                loadingTimer.stop()

                loadingText.text = "Ready"

                finishTimer.start()
            }
        }
    }


    // =====================================
    // WAIT BEFORE HOME PAGE
    // =====================================

    Timer {

        id: finishTimer

        interval: 500

        repeat: false

        onTriggered: {

            if (stack) {
                stack.replace("HomePage.qml", {
                    stack: stack
                })
            }
        }
    }
}
