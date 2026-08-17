import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: bluetoothPage

    property StackView stack
    property string connectedDevice: ""

    // =====================================
    // COLORS
    // =====================================

    property color purple: "#C957D9"
    property color darkBackground: "#0D121B"
    property color panelColor: "#151D29"
    property color cardColor: "#18212E"
    property color borderColor: "#2B374A"


    background: Rectangle {
        color: darkBackground
    }


    // =====================================
    // BACK BUTTON
    // =====================================

    Button {
        id: backButton

        text: "← Back"

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 25

        width: 95
        height: 40

        onClicked: {
            stack.pop()
        }

        background: Rectangle {
            radius: 8

            color: backButton.pressed
                   ? "#303B4D"
                   : "#202938"

            border.color: "#46536A"
            border.width: 1
        }

        contentItem: Text {
            text: backButton.text

            color: "white"

            font.pixelSize: 14

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }


    // =====================================
    // PAGE TITLE
    // =====================================

    Label {
        anchors.top: parent.top
        anchors.topMargin: 30

        anchors.horizontalCenter: parent.horizontalCenter

        text: "Bluetooth"

        color: "white"

        font.pixelSize: 32
        font.bold: true
    }


    // =====================================
    // MAIN PANEL
    // =====================================

    Rectangle {
        id: bluetoothPanel

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom

        anchors.margins: 25

        radius: 12

        color: panelColor

        border.color: borderColor
        border.width: 1


        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 25

            spacing: 18


            // =====================================
            // HEADER
            // =====================================

            RowLayout {
                Layout.fillWidth: true

                spacing: 15

                Label {
                    text: "Bluetooth"

                    color: purple

                    font.pixelSize: 28
                    font.bold: true
                }

                Item {
                    Layout.fillWidth: true
                }

                Label {
                    text: bluetoothSwitch.checked
                          ? "Enabled"
                          : "Disabled"

                    color: bluetoothSwitch.checked
                           ? "#5BE37D"
                           : "#8D9AAF"

                    font.pixelSize: 14
                }

                Switch {
                    id: bluetoothSwitch

                    checked: true

                    onCheckedChanged: {

                        if (checked) {
                            bluetoothStatus.text =
                                    "Bluetooth is enabled"
                        }
                        else {
                            bluetoothStatus.text =
                                    "Bluetooth is disabled"
                        }
                    }
                }
            }


            // =====================================
            // STATUS
            // =====================================

            Label {
                id: bluetoothStatus

                text: "Bluetooth is enabled"

                color: "#9AA8BD"

                font.pixelSize: 15

                Layout.fillWidth: true
            }


            // =====================================
            // SCAN BUTTON
            // =====================================

            Button {
                id: scanButton

                text: "Scan for Devices"

                Layout.preferredWidth: 220
                Layout.preferredHeight: 45

                enabled: bluetoothSwitch.checked

                onClicked: {

                    bluetoothStatus.text =
                            "Scanning for Bluetooth devices..."

                    scanTimer.restart()
                }

                background: Rectangle {

                    radius: 8

                    color: scanButton.enabled
                           ? (scanButton.pressed
                              ? "#A943B9"
                              : purple)
                           : "#303846"
                }

                contentItem: Text {

                    text: scanButton.text

                    color: "white"

                    font.pixelSize: 15
                    font.bold: true

                    horizontalAlignment:
                        Text.AlignHCenter

                    verticalAlignment:
                        Text.AlignVCenter
                }
            }


            // =====================================
            // SCAN TIMER
            // =====================================

            Timer {
                id: scanTimer

                interval: 1500

                repeat: false

                onTriggered: {

                    bluetoothStatus.text =
                            "Devices found"
                }
            }


            // =====================================
            // AVAILABLE DEVICES TITLE
            // =====================================

            Label {
                text: "Available Devices"

                color: "white"

                font.pixelSize: 20
                font.bold: true
            }


            // =====================================
            // DEVICE LIST AREA
            // =====================================

            Rectangle {

                Layout.fillWidth: true
                Layout.fillHeight: true

                radius: 10

                color: darkBackground

                border.color: "#263247"
                border.width: 1


                ListView {

                    id: deviceList

                    anchors.fill: parent

                    anchors.margins: 12

                    spacing: 10

                    clip: true


                    // =====================================
                    // DEVICES
                    // =====================================

                    model: ListModel {

                        ListElement {
                            deviceName: "Samsung Galaxy"
                            deviceAddress: "A4:52:6B:12:45:91"
                        }

                        ListElement {
                            deviceName: "Car Audio"
                            deviceAddress: "10:27:F5:83:21:44"
                        }

                        ListElement {
                            deviceName: "Wireless Headphones"
                            deviceAddress: "B8:7C:45:92:11:63"
                        }

                        ListElement {
                            deviceName: "Samar's Phone"
                            deviceAddress: "34:AB:12:76:55:20"
                        }
                    }


                    // =====================================
                    // DEVICE DELEGATE
                    // =====================================

                    delegate: Rectangle {

                        width: deviceList.width

                        height: 65

                        radius: 9

                        color: bluetoothPage.connectedDevice === deviceName
                               ? "#30203A"
                               : "#18212E"

                        border.color:
                            bluetoothPage.connectedDevice === deviceName
                            ? purple
                            : "#2B374A"

                        border.width: 1


                        // =====================================
                        // BLUETOOTH ICON
                        // =====================================

                        Label {

                            id: bluetoothIcon

                            anchors.left: parent.left
                            anchors.leftMargin: 18

                            anchors.verticalCenter:
                                parent.verticalCenter

                            text: "ᛒ"

                            color: purple

                            font.pixelSize: 28
                        }


                        // =====================================
                        // DEVICE INFORMATION
                        // =====================================

                        Column {

                            anchors.left: bluetoothIcon.right
                            anchors.leftMargin: 20

                            anchors.verticalCenter:
                                parent.verticalCenter

                            spacing: 2

                            Label {

                                text: deviceName

                                color: "white"

                                font.pixelSize: 15

                                font.bold: true
                            }

                            Label {

                                text: deviceAddress

                                color: "#8D9AAF"

                                font.pixelSize: 12
                            }
                        }


                        // =====================================
                        // CONNECT BUTTON
                        // =====================================
                        //
                        // IMPORTANT:
                        // The button is anchored to the RIGHT
                        // of every row, so every button is
                        // perfectly aligned.
                        //

                        Button {

                            id: connectButton

                            anchors.right: parent.right
                            anchors.rightMargin: 20

                            anchors.verticalCenter:
                                parent.verticalCenter

                            width: 110
                            height: 38

                            text:
                                bluetoothPage.connectedDevice
                                === deviceName
                                ? "Disconnect"
                                : "Connect"


                            onClicked: {

                                if (bluetoothPage.connectedDevice
                                        === deviceName) {

                                    bluetoothPage.connectedDevice = ""

                                    bluetoothStatus.text =
                                            "Disconnected from "
                                            + deviceName

                                }
                                else {

                                    bluetoothPage.connectedDevice =
                                            deviceName

                                    bluetoothStatus.text =
                                            "Connected to "
                                            + deviceName
                                }
                            }


                            background: Rectangle {

                                radius: 7

                                color:
                                    connectButton.pressed
                                    ? "#A943B9"
                                    : purple
                            }


                            contentItem: Text {

                                text: connectButton.text

                                color: "white"

                                font.pixelSize: 13

                                font.bold: true

                                horizontalAlignment:
                                    Text.AlignHCenter

                                verticalAlignment:
                                    Text.AlignVCenter
                            }
                        }
                    }
                }
            }


            // =====================================
            // CONNECTED DEVICE
            // =====================================

            Rectangle {

                Layout.fillWidth: true

                Layout.preferredHeight: 55

                radius: 9

                color:
                    bluetoothPage.connectedDevice !== ""
                    ? "#30203A"
                    : "#18212E"

                border.color:
                    bluetoothPage.connectedDevice !== ""
                    ? purple
                    : "#2B374A"

                border.width: 1


                Label {

                    anchors.centerIn: parent

                    text:
                        bluetoothPage.connectedDevice !== ""
                        ? "✓ Connected: "
                          + bluetoothPage.connectedDevice
                        : "No Bluetooth device connected"

                    color:
                        bluetoothPage.connectedDevice !== ""
                        ? purple
                        : "#8D9AAF"

                    font.pixelSize: 14

                    font.bold:
                        bluetoothPage.connectedDevice !== ""
                }
            }
        }
    }
}
