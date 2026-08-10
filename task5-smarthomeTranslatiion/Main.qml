import QtQuick
import QtQuick.Controls
import QtCore

ApplicationWindow {
    id: window

    visible: true

    width: 1000
    height: 700

    minimumWidth: 900
    minimumHeight: 650

    title: qsTr("Smart Home Dashboard")

    color: "#F5F7FC"


    // =====================================================
    // SHARED SMART HOME VALUES
    // =====================================================

    // Main brightness setting
    property real brightnessLevel: 100

    // AC temperature
    property real temperatureLevel: 22

    // Notifications
    property bool notificationsEnabled: true

    // Current language
    property string selectedLanguage: "English"


    // =====================================================
    // SAVED SETTINGS
    // =====================================================

    Settings {
        id: savedSettings

        property real brightness: 100

        property real temperature: 22

        property bool notifications: true

        property string language: "English"
    }


    // =====================================================
    // LOAD SAVED SETTINGS
    // =====================================================

    Component.onCompleted: {

        brightnessLevel =
                savedSettings.brightness

        temperatureLevel =
                savedSettings.temperature

        notificationsEnabled =
                savedSettings.notifications

        selectedLanguage =
                savedSettings.language
    }


    // =====================================================
    // SAVE SETTINGS FUNCTION
    // =====================================================

    function saveSettings(
            brightness,
            temperature,
            notifications,
            language) {

        // ---------------------------------------------
        // Update the actual application values
        // ---------------------------------------------

        brightnessLevel =
                brightness

        temperatureLevel =
                temperature

        notificationsEnabled =
                notifications

        selectedLanguage =
                language


        // ---------------------------------------------
        // Save the values
        // ---------------------------------------------

        savedSettings.brightness =
                brightness

        savedSettings.temperature =
                temperature

        savedSettings.notifications =
                notifications

        savedSettings.language =
                language


        console.log(
            "Settings saved:"
        )

        console.log(
            "Brightness:",
            brightness
        )

        console.log(
            "Temperature:",
            temperature
        )

        console.log(
            "Notifications:",
            notifications
        )

        console.log(
            "Language:",
            language
        )
    }


    // =====================================================
    // MAIN NAVIGATION
    // =====================================================

    StackView {
        id: stackView

        anchors.fill: parent

        // ---------------------------------------------
        // First page
        // ---------------------------------------------

        initialItem: LoginPage {}


        // =================================================
        // PUSH ANIMATION
        // =================================================

        pushEnter: Transition {

            ParallelAnimation {

                NumberAnimation {

                    property: "x"

                    from:
                        window.width

                    to: 0

                    duration: 200

                    easing.type:
                        Easing.OutCubic
                }


                NumberAnimation {

                    property: "opacity"

                    from: 0

                    to: 1

                    duration: 200
                }
            }
        }


        pushExit: Transition {

            ParallelAnimation {

                NumberAnimation {

                    property: "x"

                    from: 0

                    to: -80

                    duration: 200

                    easing.type:
                        Easing.OutCubic
                }


                NumberAnimation {

                    property: "opacity"

                    from: 1

                    to: 0.5

                    duration: 200
                }
            }
        }


        // =================================================
        // POP ANIMATION
        // =================================================

        popEnter: Transition {

            ParallelAnimation {

                NumberAnimation {

                    property: "x"

                    from: -80

                    to: 0

                    duration: 200

                    easing.type:
                        Easing.OutCubic
                }


                NumberAnimation {

                    property: "opacity"

                    from: 0.5

                    to: 1

                    duration: 200
                }
            }
        }


        popExit: Transition {

            ParallelAnimation {

                NumberAnimation {

                    property: "x"

                    from: 0

                    to: window.width

                    duration: 200

                    easing.type:
                        Easing.OutCubic
                }


                NumberAnimation {

                    property: "opacity"

                    from: 1

                    to: 0

                    duration: 200
                }
            }
        }
    }
}
