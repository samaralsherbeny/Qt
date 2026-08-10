import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: settingsPage

    background: Rectangle {
        color: "#F5F7FC"
    }


    // =====================================================
    // TEMPORARY SETTINGS
    // =====================================================

    property real temporaryBrightness:
        ApplicationWindow
        .window
        .brightnessLevel

    property real temporaryTemperature:
        ApplicationWindow
        .window
        .temperatureLevel

    property bool temporaryNotifications:
        ApplicationWindow
        .window
        .notificationsEnabled

    property string temporaryLanguage:
        ApplicationWindow
        .window
        .selectedLanguage


    // =====================================================
    // PAGE
    // =====================================================

    Flickable {
        anchors.fill: parent

        contentHeight:
            mainColumn.height + 40

        clip: true


        Column {
            id: mainColumn

            width: parent.width - 40

            anchors.horizontalCenter:
                parent.horizontalCenter

            topPadding: 20

            spacing: 16


            // =================================================
            // HEADER
            // =================================================

            Row {
                width: parent.width

                height: 50

                spacing: 12


                Button {
                    width: 50
                    height: 45

                    text: "←"


                    background: Rectangle {
                        radius: 12

                        color: "#22D3FF"
                    }


                    contentItem: Text {
                        text: parent.text

                        color: "white"

                        font.pixelSize: 24

                        font.bold: true

                        horizontalAlignment:
                            Text.AlignHCenter

                        verticalAlignment:
                            Text.AlignVCenter
                    }


                    onClicked: {
                        stackView.pop()
                    }
                }


                Label {
                    text: qsTr("⚙ Settings")

                    color: "#0099FF"

                    font.pixelSize: 30

                    font.bold: true

                    anchors.verticalCenter:
                        parent.verticalCenter
                }
            }


            // =================================================
            // LANGUAGE
            // =================================================

            Rectangle {
                width: parent.width

                height: 90

                radius: 18

                color: "white"

                border.color: "#22D3FF"

                border.width: 2


                Column {
                    anchors.fill: parent

                    anchors.margins: 15

                    spacing: 8


                    Label {
                        text: qsTr("🌐 Language")

                        color: "#1F2937"

                        font.pixelSize: 18

                        font.bold: true
                    }


                    ComboBox {
                        id: languageBox

                        width: 200

                        model: [
                            "English",
                            "Arabic"
                        ]


                        currentIndex:
                            temporaryLanguage ===
                            "Arabic"
                            ? 1
                            : 0


                        onCurrentTextChanged: {

                            temporaryLanguage =
                                currentText
                        }
                    }
                }
            }


            // =================================================
            // NOTIFICATIONS
            // =================================================

            Rectangle {
                width: parent.width

                height: 80

                radius: 18

                color: "white"

                border.color: "#22D3FF"

                border.width: 2


                Row {
                    anchors.fill: parent

                    anchors.margins: 15

                    spacing: 15


                    Label {
                        text:
                            qsTr(
                                "🔔 Enable Notifications"
                            )

                        color: "#1F2937"

                        font.pixelSize: 18

                        anchors.verticalCenter:
                            parent.verticalCenter
                    }


                    Switch {
                        anchors.verticalCenter:
                            parent.verticalCenter

                        checked:
                            temporaryNotifications


                        onCheckedChanged: {

                            temporaryNotifications =
                                checked
                        }
                    }
                }
            }


            // =================================================
            // BRIGHTNESS
            // =================================================

            Rectangle {
                width: parent.width

                height: 125

                radius: 18

                color: "white"

                border.color: "#22D3FF"

                border.width: 2


                Column {
                    anchors.fill: parent

                    anchors.margins: 15

                    spacing: 8


                    Row {
                        width: parent.width


                        Label {
                            text:
                                qsTr("☀ Brightness")

                            color: "#1F2937"

                            font.bold: true

                            font.pixelSize: 18
                        }


                        Item {
                            width:
                                parent.width - 170

                            height: 1
                        }


                        Label {
                            text:
                                Math.round(
                                    brightnessSlider.value
                                ) + "%"

                            color: "#0099FF"

                            font.bold: true
                        }
                    }


                    Slider {
                        id: brightnessSlider

                        width: parent.width

                        from: 0

                        to: 100

                        value:
                            temporaryBrightness


                        onValueChanged: {

                            temporaryBrightness =
                                value
                        }
                    }
                }
            }


            // =================================================
            // TEMPERATURE
            // =================================================

            Rectangle {
                width: parent.width

                height: 125

                radius: 18

                color: "white"

                border.color: "#22D3FF"

                border.width: 2


                Column {
                    anchors.fill: parent

                    anchors.margins: 15

                    spacing: 8


                    Row {
                        width: parent.width


                        Label {
                            text:
                                qsTr("🌡 Temperature")

                            color: "#1F2937"

                            font.bold: true

                            font.pixelSize: 18
                        }


                        Item {
                            width:
                                parent.width - 190

                            height: 1
                        }


                        Label {
                            text:
                                Math.round(
                                    temperatureSlider.value
                                ) + " °C"

                            color: "#FF2E93"

                            font.bold: true
                        }
                    }


                    Slider {
                        id: temperatureSlider

                        width: parent.width

                        from: 16

                        to: 30

                        value:
                            temporaryTemperature


                        onValueChanged: {

                            temporaryTemperature =
                                value
                        }
                    }
                }
            }


            // =================================================
            // SAVE / CANCEL
            // =================================================

            Row {
                anchors.horizontalCenter:
                    parent.horizontalCenter

                spacing: 20


                // CANCEL

                Button {
                    id: cancelButton

                    width: 170

                    height: 50

                    text: qsTr("Cancel")


                    background: Rectangle {
                        radius: 15

                        color: "#6B7280"
                    }


                    contentItem: Text {
                        text: cancelButton.text

                        color: "white"

                        font.bold: true

                        font.pixelSize: 17

                        horizontalAlignment:
                            Text.AlignHCenter

                        verticalAlignment:
                            Text.AlignVCenter
                    }


                    onClicked: {

                        stackView.pop()
                    }
                }


                // SAVE

                Button {
                    id: saveButton

                    width: 170

                    height: 50

                    text:
                        qsTr("💾 Save Changes")


                    background: Rectangle {
                        radius: 15

                        color: "#22D3FF"
                    }


                    contentItem: Text {
                        text: saveButton.text

                        color: "white"

                        font.bold: true

                        font.pixelSize: 17

                        horizontalAlignment:
                            Text.AlignHCenter

                        verticalAlignment:
                            Text.AlignVCenter
                    }


                    onClicked: {

                        ApplicationWindow
                        .window
                        .saveSettings(

                            Math.round(
                                temporaryBrightness
                            ),

                            Math.round(
                                temporaryTemperature
                            ),

                            temporaryNotifications,

                            temporaryLanguage
                        )


                        stackView.pop()
                    }
                }
            }


            Item {
                width: 1
                height: 20
            }
        }
    }
}
