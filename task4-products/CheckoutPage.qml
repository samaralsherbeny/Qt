import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: checkoutPage

    background: Rectangle {
        color: "#f5f7fb"
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            Label {
                text: qsTr("Checkout")
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

    ColumnLayout {
        anchors.centerIn: parent
        width: 500
        spacing: 15

        TextField {
            Layout.fillWidth: true
            placeholderText: qsTr("Full Name")
        }

        TextField {
            Layout.fillWidth: true
            placeholderText: qsTr("Address")
        }

        TextField {
            Layout.fillWidth: true
            placeholderText: qsTr("Phone Number")
        }

        ComboBox {
            Layout.fillWidth: true
            model: [
                qsTr("Cash on Delivery"),
                qsTr("Credit Card"),
                qsTr("PayPal")
            ]
        }

        Button {
            text: qsTr("Place Order")
            Layout.fillWidth: true
            onClicked: {
                console.log("Order placed")
            }
        }
    }
}
