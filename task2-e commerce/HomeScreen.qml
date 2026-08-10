import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: homeScreen
    color: "#0a0c10"

    readonly property string basePath: "file:///home/samar/task2/build/Desktop_Qt_6_11_1_Debug/"

    Column {
        anchors.fill: parent
        spacing: 10

        // Stylish Header
        Rectangle {
            width: parent.width
            height: 60
            color: "#12161f"

            Rectangle {
                width: parent.width
                height: 2
                color: "#e74c3c"
                anchors.bottom: parent.bottom
            }

            Text {
                text: "S MOTORS  |  LUXURY SHOWROOM"
                color: "#ffffff"
                font.bold: true
                font.pixelSize: 18
                font.letterSpacing: 3
                anchors.centerIn: parent
            }
        }

        ScrollView {
            width: parent.width
            height: parent.height - 70
            contentWidth: availableWidth

            Grid {
                columns: 2
                spacing: 25
                padding: 25
                anchors.horizontalCenter: parent.horizontalCenter

                // Component template for sleek car cards
                component CarCard : Rectangle {
                    id: card
                    property string carName
                    property string carImage
                    property string kitInfo
                    property string colorInfo
                    property string designerInfo
                    property string priceInfo

                    width: 270; height: 210
                    radius: 12
                    color: mouse.containsMouse ? "#1a202c" : "#131722"
                    border.color: mouse.containsMouse ? "#e74c3c" : "#222a3a"
                    border.width: mouse.containsMouse ? 2 : 1

                    Behavior on color { ColorAnimation { duration: 200 } }
                    Behavior on border.color { ColorAnimation { duration: 200 } }

                    // Card Content
                    Column {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 8

                        Text {
                            text: card.carName
                            color: mouse.containsMouse ? "#e74c3c" : "#ffffff"
                            font.bold: true
                            font.pixelSize: 15
                            anchors.horizontalCenter: parent.horizontalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }

                        Image {
                            id: img
                            source: homeScreen.basePath + card.carImage
                            width: 200; height: 90
                            fillMode: Image.PreserveAspectFit
                            anchors.horizontalCenter: parent.horizontalCenter
                            scale: mouse.containsMouse ? 1.08 : 1.0

                            Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
                        }

                        // Hover details layout
                        Item {
                            width: parent.width
                            height: 50

                            // Default prompt
                            Text {
                                text: "HOVER TO REVEAL SPECS"
                                color: "#4a5568"
                                font.pixelSize: 10
                                font.bold: true
                                font.letterSpacing: 1
                                visible: !mouse.containsMouse
                                anchors.centerIn: parent
                            }

                            // Active Specs Overlay
                            Column {
                                anchors.centerIn: parent
                                spacing: 3
                                visible: mouse.containsMouse
                                opacity: mouse.containsMouse ? 1.0 : 0.0

                                Behavior on opacity { NumberAnimation { duration: 200 } }

                                Text { text: "• " + card.kitInfo; color: "#cbd5e0"; font.pixelSize: 11; font.bold: true }
                                Text { text: "• " + card.colorInfo; color: "#a0aec0"; font.pixelSize: 10 }
                                Text { text: card.designerInfo; color: "#e74c3c"; font.pixelSize: 10; font.bold: true }
                            }
                        }
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }

                // 1. BMW 7 Series
                CarCard {
                    carName: "BMW 7 Series (G70)"
                    carImage: "car1.png"
                    kitInfo: "Carbon Fiber Body Kit"
                    colorInfo: "Dark Grey Sedan"
                    designerInfo: "Renegade Design"
                }

                // 2. BMW XM
                CarCard {
                    carName: "BMW XM"
                    carImage: "car2.png"
                    kitInfo: "Widebody Carbon Fiber"
                    colorInfo: "Black SUV"
                    designerInfo: "Renegade Design"
                }

                // 3. BMW X6 LCI
                CarCard {
                    carName: "BMW X6 LCI"
                    carImage: "car3.png"
                    kitInfo: "Carbon Fiber Aero Kit"
                    colorInfo: "White Coupe SUV"
                    designerInfo: "Renegade Design"
                }

                // 4. BMW X5 LCI
                CarCard {
                    carName: "BMW X5 (G05) LCI"
                    carImage: "car4.png"
                    kitInfo: "Carbon Fiber Sport Package"
                    colorInfo: "Matte Grey SUV"
                    designerInfo: "Renegade Design"
                }
            }
        }
    }
}
