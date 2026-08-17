import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: homePage

    property StackView stack

    background: Rectangle {
        color: "#10141C"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 30

        Label {
            text: "Media Player"
            font.pixelSize: 42
            font.bold: true
            color: "white"

            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            columns: 2
            rows: 2

            columnSpacing: 30
            rowSpacing: 30

            Layout.alignment: Qt.AlignCenter

            Button {
                text: "Local Media"

                Layout.preferredWidth: 350
                Layout.preferredHeight: 180

                onClicked: {
                    stack.push(
                        "LocalMediaPage.qml",
                        { stack: stack }
                    )
                }
            }

            Button {
                text: "Radio"

                Layout.preferredWidth: 350
                Layout.preferredHeight: 180

                onClicked: {
                    stack.push(
                        "RadioPage.qml",
                        { stack: stack }
                    )
                }
            }

            Button {
                text: "USB Media"

                Layout.preferredWidth: 350
                Layout.preferredHeight: 180

                onClicked: {
                    stack.push(
                        "UsbPage.qml",
                        { stack: stack }
                    )
                }
            }

            Button {
                text: "Bluetooth"

                Layout.preferredWidth: 350
                Layout.preferredHeight: 180

                onClicked: {
                    stack.push(
                        "BluetoothPage.qml",
                        { stack: stack }
                    )
                }
            }
        }
    }
}
