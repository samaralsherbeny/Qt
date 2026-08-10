import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: cartPage

    background: Rectangle {
        color: "#f5f7fb"
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            Label {
                text: qsTr("Shopping Cart")
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
        spacing: 20

        Label {
            text: qsTr("Your cart is empty")
            font.pixelSize: 25
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("Add products to your cart to see them here.")
            color: "#777777"
            Layout.alignment: Qt.AlignHCenter
        }

        Button {
            text: qsTr("Continue Shopping")
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                stackView.pop()
            }
        }
    }
}
