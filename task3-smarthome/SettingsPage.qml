import QtQuick
import QtQuick.Controls

Page {
    id: settingsPage

    background: Rectangle {
        color: "#F5F7FC"
    }

    // Helper function to safely navigate back
    function goBack() {
        if (typeof stackView !== "undefined" && stackView) {
            stackView.pop()
        } else if (StackView.view) {
            StackView.view.pop()
        }
    }

    Flickable {
        anchors.fill: parent
        contentHeight: mainColumn.height + 60
        clip: true

        Column {
            id: mainColumn
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 20
            spacing: 16

            // Title
            Label {
                text: "⚙ Settings"
                font.pixelSize: 32
                font.bold: true
                color: "#0099FF"
            }

            // Language
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
                        text: "🌐 Language"
                        color: "#1F2937"
                        font.pixelSize: 18
                        font.bold: true
                    }

                    ComboBox {
                        width: 180
                        model: ["English", "Arabic", "French"]
                        onCurrentTextChanged: {
                            console.log("Language:", currentText)
                        }
                    }
                }
            }

            // Brightness
            Rectangle {
                width: parent.width
                height: 120
                radius: 18
                color: "white"
                border.color: "#22D3FF"
                border.width: 2

                Column {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10

                    Label {
                        text: "☀️ Brightness"
                        color: "#1F2937"
                        font.bold: true
                        font.pixelSize: 18
                    }

                    Slider {
                        id: brightness
                        width: parent.width - 20
                        from: 0
                        to: 100
                        value: 50
                        onValueChanged: {
                            console.log("Brightness:", Math.round(value))
                        }
                    }

                    Label {
                        text: Math.round(brightness.value) + "%"
                        color: "#0099FF"
                        font.pixelSize: 14
                    }
                }
            }

            // Temperature
            Rectangle {
                width: parent.width
                height: 210
                radius: 18
                color: "white"
                border.color: "#22D3FF"
                border.width: 2

                Column {
                    anchors.centerIn: parent
                    spacing: 10

                    Label {
                        text: "🌡 Temperature"
                        color: "#1F2937"
                        font.bold: true
                        font.pixelSize: 18
                    }

                    Dial {
                        id: tempDial
                        from: 16
                        to: 30
                        value: 22
                        onValueChanged: {
                            console.log("Temperature:", Math.round(value))
                        }
                    }

                    Label {
                        text: Math.round(tempDial.value) + " °C"
                        color: "#0099FF"
                        font.pixelSize: 20
                        font.bold: true
                    }
                }
            }

            // Notifications
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
                        text: "🔔 Enable Notifications"
                        color: "#1F2937"
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    CheckBox {
                        anchors.verticalCenter: parent.verticalCenter
                        checked: true
                        onCheckedChanged: {
                            console.log("Notifications:", checked)
                        }
                    }
                }
            }

            // Buttons
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Button {
                    id: saveButton
                    width: 170
                    height: 50
                    text: "💾 Save"

                    background: Rectangle {
                        radius: 15
                        color: "#22D3FF"
                    }

                    contentItem: Text {
                        text: saveButton.text
                        color: "white"
                        font.bold: true
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        console.log("Settings Saved")
                        settingsPage.goBack()
                    }
                }

                Button {
                    id: backButton
                    width: 170
                    height: 50
                    text: "⬅ Back"

                    background: Rectangle {
                        radius: 15
                        color: "#FF2E93"
                    }

                    contentItem: Text {
                        text: backButton.text
                        color: "white"
                        font.bold: true
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        settingsPage.goBack()
                    }
                }
            }
        }
    }
}
