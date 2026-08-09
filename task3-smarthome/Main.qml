import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window

    visible: true

    width: 1000
    height: 700

    minimumWidth: 900
    minimumHeight: 650

    title: "Smart Home Dashboard"

    color: "#0B1020"

    StackView {
        id: stackView

        anchors.fill: parent

        initialItem: LoginPage {}

        // ---------- Push Animation ----------
        pushEnter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "x"
                    from: window.width
                    to: 0
                    duration: 150
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 150
                }
            }
        }

        pushExit: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "x"
                    from: 0
                    to: -80
                    duration: 150
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0.5
                    duration: 150
                }
            }
        }

        // ---------- Pop Animation ----------
        popEnter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "x"
                    from: -80
                    to: 0
                    duration: 150
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.5
                    to: 1
                    duration: 150
                }
            }
        }

        popExit: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "x"
                    from: 0
                    to: window.width
                    duration: 150
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 150
                }
            }
        }
    }
}
