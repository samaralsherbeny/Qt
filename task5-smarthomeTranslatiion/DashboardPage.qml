import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: dashboardPage

    background: Rectangle {
        color: "#F5F7FC"
    }


    // =====================================================
    // DEVICE MODEL
    // =====================================================

    ListModel {
        id: deviceModel

        ListElement {
            name: "💡 Living Room Light"
            icon: "qrc:/pictures/light.png"
            deviceType: "brightness"
            deviceValue: 50
        }

        ListElement {
            name: "🛏 Bedroom Light"
            icon: "qrc:/pictures/light.png"
            deviceType: "brightness"
            deviceValue: 50
        }

        ListElement {
            name: "❄ Air Conditioner"
            icon: "qrc:/pictures/ac.png"
            deviceType: "temperature"
            deviceValue: 22
        }

        ListElement {
            name: "🌀 Fan"
            icon: "qrc:/pictures/fan.png"
            deviceType: "speed"
            deviceValue: 70
        }

        ListElement {
            name: "🚗 Garage Door"
            icon: "qrc:/pictures/garage.png"
            deviceType: "garage"
            deviceValue: 0
        }
    }


    // =====================================================
    // MAIN LAYOUT
    // =====================================================

    ColumnLayout {
        anchors.fill: parent

        spacing: 0


        // =================================================
        // DEVICE LIST
        // =================================================

        ListView {
            id: deviceList

            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true

            spacing: 12

            model: deviceModel


            // =================================================
            // HEADER
            // =================================================

            header: Column {
                width: deviceList.width

                spacing: 18

                topPadding: 20

                bottomPadding: 15


                // =============================================
                // WELCOME CARD
                // =============================================

                Rectangle {
                    width: parent.width - 40

                    height: 95

                    radius: 20

                    color: "white"

                    border.color: "#22D3FF"

                    border.width: 2

                    anchors.horizontalCenter:
                        parent.horizontalCenter


                    Row {
                        anchors.fill: parent

                        anchors.margins: 15

                        spacing: 18


                        // -------------------------------------
                        // HOME ICON
                        // -------------------------------------

                        Rectangle {
                            width: 65

                            height: 65

                            radius: 15

                            color: "#F5F7FC"

                            border.color:
                                "#22D3FF"

                            border.width: 2


                            Image {
                                anchors.fill: parent

                                anchors.margins: 6

                                source:
                                    "qrc:/pictures/home.png"

                                fillMode:
                                    Image.PreserveAspectFit

                                smooth: true
                            }
                        }


                        // -------------------------------------
                        // TITLE
                        // -------------------------------------

                        Column {
                            anchors.verticalCenter:
                                parent.verticalCenter

                            spacing: 3


                            Text {
                                text:
                                    qsTr("Welcome Home")

                                color:
                                    "#6B7280"

                                font.pixelSize:
                                    18
                            }


                            Text {
                                text:
                                    qsTr(
                                        "Smart Home Dashboard"
                                    )

                                color:
                                    "#0099FF"

                                font.pixelSize:
                                    28

                                font.bold:
                                    true
                            }
                        }
                    }
                }


                // =============================================
                // STATUS CARD
                // =============================================

                Rectangle {
                    width: parent.width - 40

                    height: 140

                    radius: 20

                    color: "white"

                    border.color:
                        "#FF2E93"

                    border.width: 2

                    anchors.horizontalCenter:
                        parent.horizontalCenter


                    Column {
                        anchors.left:
                            parent.left

                        anchors.leftMargin:
                            20

                        anchors.verticalCenter:
                            parent.verticalCenter

                        spacing: 6


                        Text {
                            text:
                                qsTr(
                                    "🏠 Home Connected"
                                )

                            color:
                                "#1F2937"

                            font.pixelSize:
                                24

                            font.bold:
                                true
                        }


                        Text {
                            text:
                                qsTr(
                                    "WiFi Status : Connected"
                                )

                            color:
                                "#22D3FF"

                            font.pixelSize:
                                16
                        }


                        Text {
                            text:
                                qsTr(
                                    "Devices Online : 5"
                                )

                            color:
                                "#22D3FF"

                            font.pixelSize:
                                16
                        }


                        Text {
                            text:
                                qsTr(
                                    "Energy Usage : Normal"
                                )

                            color:
                                "#FF2E93"

                            font.pixelSize:
                                16
                        }
                    }
                }


                // =============================================
                // SECTION TITLE
                // =============================================

                Text {
                    text:
                        qsTr("Smart Devices")

                    color:
                        "#0099FF"

                    font.pixelSize:
                        26

                    font.bold:
                        true

                    leftPadding:
                        20
                }
            }


            // =================================================
            // DEVICE DELEGATE
            // =================================================

            delegate: Item {

                width:
                    deviceList.width

                height:
                    202


                DeviceCard {

                    anchors.horizontalCenter:
                        parent.horizontalCenter

                    width:
                        parent.width - 40

                    height:
                        190


                    deviceName:
                        model.name

                    imageSource:
                        model.icon

                    deviceType:
                        model.deviceType

                    value:
                        model.deviceValue
                }
            }
        }


        // =====================================================
        // BOTTOM NAVIGATION
        // =====================================================

        Rectangle {
            Layout.fillWidth: true

            height: 85

            color: "white"

            border.color:
                "#22D3FF"

            border.width: 1


            Row {
                anchors.centerIn: parent

                spacing: 20


                // =============================================
                // HOME BUTTON
                // =============================================

                Button {
                    id: homeButton

                    width: 170

                    height: 50

                    text:
                        qsTr("🏠 Home")


                    background: Rectangle {

                        radius: 15

                        color:
                            "#22D3FF"
                    }


                    contentItem: Text {

                        text:
                            homeButton.text

                        color:
                            "white"

                        font.pixelSize:
                            18

                        font.bold:
                            true

                        horizontalAlignment:
                            Text.AlignHCenter

                        verticalAlignment:
                            Text.AlignVCenter
                    }


                    onClicked: {

                        deviceList.positionViewAtBeginning()
                    }
                }


                // =============================================
                // SETTINGS BUTTON
                // =============================================

                Button {
                    id: settingsButton

                    width: 170

                    height: 50

                    text:
                        qsTr("⚙ Settings")


                    background: Rectangle {

                        radius: 15

                        color:
                            "#FF2E93"
                    }


                    contentItem: Text {

                        text:
                            settingsButton.text

                        color:
                            "white"

                        font.pixelSize:
                            18

                        font.bold:
                            true

                        horizontalAlignment:
                            Text.AlignHCenter

                        verticalAlignment:
                            Text.AlignVCenter
                    }


                    onClicked: {

                        stackView.push(
                            "SettingsPage.qml"
                        )
                    }
                }
            }
        }
    }
}
