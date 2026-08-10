import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

Page {
    id: settingsPage

    background: Rectangle {
        color: "#f5f7fb"
    }

    Settings {
        id: appSettings
        category: "UserSettings"

        property string language: "English"
        property bool notificationsEnabled: true
        property bool promoOffersEnabled: true
        property real fontScale: 1.0
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Label {
                text: qsTr("Settings")
                font.pixelSize: 25
                font.bold: true
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Back")
                onClicked: stackView.pop()
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: parent.width - 80
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Item { Layout.preferredHeight: 10 }

            Label {
                text: qsTr("Language")
                font.pixelSize: 20
                font.bold: true
            }

            ComboBox {
                id: langCombo
                Layout.fillWidth: true
                model: ["English", "Arabic"]
                currentIndex: appSettings.language === "Arabic" ? 1 : 0
            }

            Label {
                text: qsTr("Notifications")
                font.pixelSize: 20
                font.bold: true
            }

            Switch {
                id: notifSwitch
                text: qsTr("Enable Notifications")
                checked: appSettings.notificationsEnabled
            }

            CheckBox {
                id: promoCheck
                text: qsTr("Receive promotional offers")
                checked: appSettings.promoOffersEnabled
                enabled: notifSwitch.checked
            }

            Label {
                text: qsTr("Display Size")
                font.pixelSize: 20
                font.bold: true
            }

            Slider {
                id: sizeSlider
                Layout.fillWidth: true
                from: 0.8
                to: 1.4
                value: appSettings.fontScale
            }

            Item { Layout.preferredHeight: 15 }

            // Save Settings Button
            Button {
                text: qsTr("Save Settings")
                Layout.fillWidth: true
                implicitHeight: 50

                background: Rectangle {
                    color: parent.down ? "#115293" : "#1976d2"
                    radius: 10
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    // Save values locally
                    appSettings.language = langCombo.currentText
                    appSettings.notificationsEnabled = notifSwitch.checked
                    appSettings.promoOffersEnabled = promoCheck.checked
                    appSettings.fontScale = sizeSlider.value

                    // Switch language and layout direction globally
                    if (typeof translationManager !== "undefined") {
                        translationManager.setLanguage(langCombo.currentText)
                    }

                    savedMessageDialog.open()
                }
            }

            Item { Layout.preferredHeight: 30 }
        }
    }

    Dialog {
        id: savedMessageDialog
        title: qsTr("Success")
        anchors.centerIn: parent
        modal: true
        standardButtons: Dialog.Ok

        Label {
            text: qsTr("Your settings have been saved successfully!")
            padding: 20
        }
    }
}
