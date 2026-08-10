import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: detailsPage

    // These properties receive data passed via stackView.push(...)
    property string productName: ""
    property string productPrice: ""
    property string productImage: ""

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Label {
                text: qsTr("Product Details")
                font.pixelSize: 22
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
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Item { Layout.preferredHeight: 10 }

            Image {
                source: detailsPage.productImage
                Layout.preferredHeight: 220
                Layout.fillWidth: true
                fillMode: Image.PreserveAspectFit
            }

            Label {
                text: detailsPage.productName
                font.pixelSize: 22
                font.bold: true
            }

            Label {
                text: detailsPage.productPrice
                font.pixelSize: 20
                color: "#1976d2"
                font.bold: true
            }

            Label {
                text: qsTr("Description")
                font.pixelSize: 18
                font.bold: true
            }

            Label {
                text: qsTr("High quality product with excellent performance, comfortable design, and long battery life.")
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                color: "#666666"
            }

            Button {
                text: qsTr("Add to Cart")
                Layout.fillWidth: true
                implicitHeight: 48
            }
        }
    }
}
