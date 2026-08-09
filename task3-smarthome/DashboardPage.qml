import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: dashboardPage

    background: Rectangle {
        color: "#F5F7FC"
    }

    // List Model for dynamic device cards
    ListModel {
        id: deviceModel
        ListElement { name: "💡 Living Room Light"; icon: "qrc:/qt/qml/task3qt/images/light.png"; bat: 90 }
        ListElement { name: "🛏 Bedroom Light"; icon: "qrc:/qt/qml/task3qt/images/light.png"; bat: 70 }
        ListElement { name: "❄ Air Conditioner"; icon: "qrc:/qt/qml/task3qt/images/ac.png"; bat: 60 }
        ListElement { name: "🌀 Fan"; icon: "qrc:/qt/qml/task3qt/images/fan.png"; bat: 85 }
        ListElement { name: "🚗 Garage Door"; icon: "qrc:/qt/qml/task3qt/images/garage.png"; bat: 100 }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 12
            model: deviceModel

            // Header Section
            header: Column {
                width: parent.width
                spacing: 18
                bottomPadding: 15

                // HEADER CARD
                Rectangle {
                    width: parent.width - 40
                    height: 95
                    radius: 20
                    color: "white"
                    border.color: "#22D3FF"
                    border.width: 2
                    anchors.horizontalCenter: parent.horizontalCenter

                    Row {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 18

                        Rectangle {
                            width: 65
                            height: 65
                            radius: 15
                            color: "#F5F7FC"
                            border.color: "#22D3FF"
                            border.width: 2

                            Image {
                                anchors.fill: parent
                                anchors.margins: 6
                                source: "qrc:/qt/qml/task3qt/images/home.png"
                                fillMode: Image.PreserveAspectFit
                                smooth: false
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            Text { text: "Welcome Home"; color: "#6B7280"; font.pixelSize: 18 }
                            Text { text: "Smart Home Dashboard"; color: "#0099FF"; font.pixelSize: 28; font.bold: true }
                        }
                    }
                }

                // STATUS CARD
                Rectangle {
                    width: parent.width - 40
                    height: 140
                    radius: 20
                    color: "white"
                    border.color: "#FF2E93"
                    border.width: 2
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 6

                        Text { text: "🏠 Home Connected"; color: "#1F2937"; font.pixelSize: 24; font.bold: true }
                        Text { text: "WiFi Status : Connected"; color: "#22D3FF"; font.pixelSize: 16 }
                        Text { text: "Devices Online : 5"; color: "#22D3FF"; font.pixelSize: 16 }
                        Text { text: "Energy Usage : Normal"; color: "#FF2E93"; font.pixelSize: 16 }
                    }
                }

                Text {
                    text: "Smart Devices"
                    color: "#0099FF"
                    font.pixelSize: 26
                    font.bold: true
                    leftPadding: 20
                }
            }

            // Device Item Delegate
            delegate: Item {
                width: ListView.view.width
                height: 125

                DeviceCard {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 40
                    deviceName: model.name
                    imageSource: model.icon
                    battery: model.bat
                }
            }
        }

        // BOTTOM NAVIGATION
        Rectangle {
            Layout.fillWidth: true
            height: 85
            color: "white"
            border.color: "#22D3FF"
            border.width: 1

            Row {
                anchors.centerIn: parent
                spacing: 30

                // HOME BUTTON
                Button {
                    text: "🏠 Home"
                    implicitWidth: 160
                    implicitHeight: 48

                    background: Rectangle {
                        radius: 16
                        color: "#22D3FF"
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 18
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        if (typeof stackView !== "undefined") {
                            stackView.pop(null)
                        } else if (StackView.view) {
                            StackView.view.pop(null)
                        }
                    }
                }

                // SETTINGS BUTTON
                Button {
                    text: "⚙ Settings"
                    implicitWidth: 160
                    implicitHeight: 48

                    background: Rectangle {
                        radius: 16
                        color: "#FF2E93"
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 18
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        if (typeof stackView !== "undefined") {
                            stackView.push("SettingsPage.qml")
                        } else if (StackView.view) {
                            StackView.view.push("SettingsPage.qml")
                        }
                    }
                }
            }
        }
    }
}
