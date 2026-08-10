import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: productsPage

    property string selectedCategory: "all"

    background: Rectangle {
        color: "#f5f7fb"
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15

            Button {
                text: qsTr("Back")
                onClicked: stackView.pop()
            }

            Text {
                text: qsTr("Products")
                font.bold: true
                font.pixelSize: 20
                color: "#1976d2"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                text: qsTr("Cart")
                onClicked: stackView.push(Qt.resolvedUrl("CartPage.qml"))
            }
        }
    }

    // Complete Product List including "home" category items
    readonly property var allProducts: [
        // Electronics
        { name: qsTr("Wireless Headphones"), price: "$59.99", category: "electronics", image: "qrc:/icons/wireless headphones.png" },
        { name: qsTr("Smart Watch"), price: "$89.99", category: "electronics", image: "qrc:/icons/smartwatch.png" },
        { name: qsTr("Smartphone"), price: "$499.99", category: "electronics", image: "qrc:/icons/smart phone.png" },
        { name: qsTr("Laptop"), price: "$899.99", category: "electronics", image: "qrc:/icons/laptop.png" },

        // Clothes
        { name: qsTr("T-Shirt"), price: "$19.99", category: "clothes", image: "qrc:/icons/tshirt.png" },
        { name: qsTr("Dress"), price: "$49.99", category: "clothes", image: "qrc:/icons/dress.png" },
        { name: qsTr("Pants"), price: "$34.99", category: "clothes", image: "qrc:/icons/pants.png" },
         { name: qsTr("Shorts"), price: "$34.99", category: "clothes", image: "qrc:/icons/shorts.png" },

        // Shoes
        { name: qsTr("Running Shoes"), price: "$74.99", category: "shoes", image: "qrc:/icons/running shoes.png" },
        { name: qsTr("Sneakers"), price: "$64.99", category: "shoes", image: "qrc:/icons/sneakers.png" },
        { name: qsTr("Leather shoes"), price: "$64.99", category: "shoes", image: "qrc:/icons/leather shoes.png" },
        { name: qsTr("Heels"), price: "$64.99", category: "shoes", image: "qrc:/icons/heels.png" },

        // Home Category Products
        { name: qsTr("Bluetooth Speaker"), price: "$39.99", category: "home", image: "qrc:/icons/bluetooth speaker.png" },
        { name: qsTr("Smart TV"), price: "$399.99", category: "home", image: "qrc:/icons/tv.png" },
        { name: qsTr("Shop Decor Item"), price: "$29.99", category: "home", image: "qrc:/icons/decor.png" }
    ]

    // Filtering logic matching "home"
    property var filteredProducts: {
        if (selectedCategory === "all" || selectedCategory === "") {
            return allProducts
        }
        var list = []
        for (var i = 0; i < allProducts.length; i++) {
            if (allProducts[i].category === selectedCategory) {
                list.push(allProducts[i])
            }
        }
        return list
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15

        GridView {
            id: gridView
            Layout.fillWidth: true
            Layout.fillHeight: true
            cellWidth: parent.width > 500 ? parent.width / 3 : parent.width / 2
            cellHeight: 260
            clip: true

            model: productsPage.filteredProducts

            delegate: Item {
                width: gridView.cellWidth - 10
                height: gridView.cellHeight - 10

                ProductCard {
                    anchors.fill: parent
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
    }
}
