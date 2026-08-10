import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property string productName: ""
    property string productPrice: ""
    property string productImage: ""

    // Signal emitted when tapping the card
    signal clicked()
    signal addToCartClicked()

    implicitWidth: 200
    implicitHeight: 250

    Rectangle {
        anchors.fill: parent
        color: "white"
        radius: 12
        border.color: "#e0e0e0"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            // Product Image Container
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Image {
                    anchors.fill: parent
                    source: root.productImage
                    fillMode: Image.PreserveAspectFit
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
            }

            // Product Title
            Text {
                text: root.productName
                font.bold: true
                font.pixelSize: 14
                elide: Text.ElideRight
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
            }

            // Price Label
            Text {
                text: root.productPrice
                color: "#1976d2"
                font.bold: true
                font.pixelSize: 14
                Layout.fillWidth: true
            }

            // Add to Cart Button
            Button {
                text: qsTr("Add to Cart")
                Layout.fillWidth: true
                implicitHeight: 36

                onClicked: {
                    root.addToCartClicked()
                }
            }
        }

        // MouseArea over card area (excluding button) to trigger Details page
        MouseArea {
            anchors.fill: parent
            z: -1
            onClicked: root.clicked()
        }
    }
}
