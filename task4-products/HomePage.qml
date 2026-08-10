import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: homePage

    background: Rectangle {
        color: "#f5f7fb"
    }

    // Featured Products list displayed on the Home Page
    readonly property var homeProducts: [
        {
            name: qsTr("Wireless Headphones"),
            price: "$59.99",
            image: "qrc:/icons/wireless headphones.png"
        },
        {
            name: qsTr("Smart Watch"),
            price: "$89.99",
            image: "qrc:/icons/smartwatch.png"
        },
        {
            name: qsTr("Running Shoes"),
            price: "$74.99",
            image: "qrc:/icons/running shoes.png"
        }
    ]

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Text {
                text: "ShopEase"
                font.bold: true
                font.pixelSize: 22
                color: "#1976d2"
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Products")
                onClicked: stackView.push(Qt.resolvedUrl("ProductsPage.qml"))
            }
            Button {
                text: qsTr("Cart")
                onClicked: stackView.push(Qt.resolvedUrl("CartPage.qml"))
            }
            Button {
                text: qsTr("Settings")
                onClicked: stackView.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: Math.min(parent.width - 40, 800)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Item { Layout.preferredHeight: 10 }

            // Promotional Banner
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: "#1976d2"
                radius: 12

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: qsTr("Special Offers")
                        color: "white"
                        font.bold: true
                        font.pixelSize: 22
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: qsTr("Up to 50% OFF")
                        color: "white"
                        font.pixelSize: 15
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Categories Section
            Text {
                text: qsTr("Categories")
                font.bold: true
                font.pixelSize: 20
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                // Electronics
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "white"
                    radius: 10
                    border.color: "#e0e0e0"

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 5
                        Image {
                            source: "qrc:/icons/electronics.png"
                            Layout.preferredWidth: 28
                            Layout.preferredHeight: 28
                            fillMode: Image.PreserveAspectFit
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("Electronics")
                            font.bold: true
                            font.pixelSize: 12
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: stackView.push(Qt.resolvedUrl("ProductsPage.qml"), { selectedCategory: "electronics" })
                    }
                }

                // Clothes
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "white"
                    radius: 10
                    border.color: "#e0e0e0"

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 5
                        Image {
                            source: "qrc:/icons/clothes.png"
                            Layout.preferredWidth: 28
                            Layout.preferredHeight: 28
                            fillMode: Image.PreserveAspectFit
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("Clothes")
                            font.bold: true
                            font.pixelSize: 12
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: stackView.push(Qt.resolvedUrl("ProductsPage.qml"), { selectedCategory: "clothes" })
                    }
                }

                // Shoes
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "white"
                    radius: 10
                    border.color: "#e0e0e0"

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 5
                        Image {
                            source: "qrc:/icons/shoes.png"
                            Layout.preferredWidth: 28
                            Layout.preferredHeight: 28
                            fillMode: Image.PreserveAspectFit
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("Shoes")
                            font.bold: true
                            font.pixelSize: 12
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: stackView.push(Qt.resolvedUrl("ProductsPage.qml"), { selectedCategory: "shoes" })
                    }
                }

                // Home Category Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "white"
                    radius: 10
                    border.color: "#e0e0e0"

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 5
                        Image {
                            source: "qrc:/icons/shop.png"
                            Layout.preferredWidth: 28
                            Layout.preferredHeight: 28
                            fillMode: Image.PreserveAspectFit
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("Home")
                            font.bold: true
                            font.pixelSize: 12
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: stackView.push(Qt.resolvedUrl("ProductsPage.qml"), { selectedCategory: "home" })
                    }
                }
            }

            // Featured Products Section
            Text {
                text: qsTr("Featured Products")
                font.bold: true
                font.pixelSize: 20
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                Repeater {
                    model: homePage.homeProducts

                    ProductCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 260
                        productName: modelData.name
                        productPrice: modelData.price
                        productImage: modelData.image

                        onClicked: {
                            stackView.push(Qt.resolvedUrl("ProductDetails.qml"), {
                                productName: modelData.name,
                                productPrice: modelData.price,
                                productImage: modelData.image
                            })
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 20 }
        }
    }
}
