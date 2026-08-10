import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    // =====================================================
    // PROPERTIES
    // =====================================================

    property string deviceName: ""
    property string imageSource: ""
    property string deviceType: "brightness"

    // Current slider value
    property real value: 50

    // Device ON / OFF
    property bool deviceOn: true


    // =====================================================
    // CARD
    // =====================================================

    width: 430
    height: 190

    radius: 18

    color: "white"

    border.color:
        deviceOn
        ? "#22D3FF"
        : "#E5E7EB"

    border.width: 2


    // =====================================================
    // MAIN CONTENT
    // =====================================================

    Column {
        anchors.fill: parent

        anchors.margins: 18

        spacing: 8


        // =================================================
        // TOP ROW
        // =================================================

        Row {
            width: parent.width
            height: 55

            spacing: 15


            // =============================================
            // DEVICE IMAGE
            // =============================================

            Rectangle {
                width: 55
                height: 55

                radius: 14

                color: "#F5F7FC"

                border.color:
                    deviceOn
                    ? "#22D3FF"
                    : "#D1D5DB"

                border.width: 2


                Image {
                    anchors.fill: parent

                    anchors.margins: 7

                    source: root.imageSource

                    fillMode:
                        Image.PreserveAspectFit

                    smooth: true

                    opacity:
                        deviceOn
                        ? 1.0
                        : 0.4
                }
            }


            // =============================================
            // DEVICE INFORMATION
            // =============================================

            Column {
                width: parent.width - 140

                anchors.verticalCenter:
                    parent.verticalCenter

                spacing: 3


                Text {
                    text: root.deviceName

                    color:
                        deviceOn
                        ? "#1F2937"
                        : "#9CA3AF"

                    font.pixelSize: 18

                    font.bold: true

                    elide:
                        Text.ElideRight

                    width: parent.width
                }


                Text {
                    text:
                        deviceOn
                        ? qsTr("🟢 Online")
                        : qsTr("🔴 Offline")

                    color:
                        deviceOn
                        ? "#22C55E"
                        : "#EF4444"

                    font.pixelSize: 12

                    font.bold: true
                }
            }


            // =============================================
            // ON / OFF SWITCH
            // =============================================

            Switch {
                id: deviceSwitch

                checked:
                    root.deviceOn

                anchors.verticalCenter:
                    parent.verticalCenter


                onCheckedChanged: {

                    if (root.deviceOn !== checked)
                        root.deviceOn = checked

                    console.log(
                        root.deviceName +
                        (checked ? " ON" : " OFF")
                    )
                }
            }
        }


        // =================================================
        // SLIDER LABEL
        // =================================================

        Row {
            width: parent.width

            height: 20


            Text {
                text: {

                    if (root.deviceType ===
                        "temperature") {

                        return qsTr("Temperature")
                    }

                    if (root.deviceType ===
                        "speed") {

                        return qsTr("Speed")
                    }

                    if (root.deviceType ===
                        "garage") {

                        return qsTr("Position")
                    }

                    return qsTr("Brightness")
                }

                color: "#6B7280"

                font.pixelSize: 12

                anchors.verticalCenter:
                    parent.verticalCenter
            }


            Item {
                width: parent.width - 120
                height: 1
            }


            Text {
                text: {

                    if (root.deviceType ===
                        "temperature") {

                        return Math.round(
                            root.value
                        ) + " °C"
                    }

                    return Math.round(
                        root.value
                    ) + "%"
                }

                color:
                    root.deviceOn
                    ? "#0099FF"
                    : "#9CA3AF"

                font.pixelSize: 13

                font.bold: true

                anchors.verticalCenter:
                    parent.verticalCenter
            }
        }


        // =================================================
        // SLIDER AREA
        // =================================================

        Item {
            id: sliderArea

            width: parent.width

            height: 35


            // =============================================
            // SLIDER TRACK
            // =============================================

            Rectangle {
                id: sliderTrack

                anchors.left:
                    parent.left

                anchors.right:
                    parent.right

                anchors.verticalCenter:
                    parent.verticalCenter

                height: 8

                radius: 4

                color: "#E5E7EB"


                // =========================================
                // PINK FILLED PART
                // =========================================

                Rectangle {
                    id: pinkFill

                    width:
                        sliderArea.width *
                        deviceSlider.visualPosition

                    height:
                        sliderTrack.height

                    radius: 4

                    color:
                        root.deviceOn
                        ? "#FF2E93"
                        : "#D1D5DB"
                }
            }


            // =============================================
            // ACTUAL SLIDER
            // =============================================

            Slider {
                id: deviceSlider

                anchors.fill: parent

                enabled:
                    root.deviceOn


                // -----------------------------------------
                // VALUE RANGE
                // -----------------------------------------

                from:
                    root.deviceType === "temperature"
                    ? 16
                    : 0

                to:
                    root.deviceType === "temperature"
                    ? 30
                    : 100


                value:
                    root.value


                // -----------------------------------------
                // UPDATE DEVICE VALUE
                // -----------------------------------------

                onValueChanged: {

                    if (root.value !== value) {

                        root.value = value

                        console.log(
                            root.deviceName +
                            ": " +
                            Math.round(value)
                        )
                    }
                }


                // =========================================
                // REMOVE DEFAULT QT SLIDER BACKGROUND
                // =========================================

                background: Item {
                    width: 0
                    height: 0
                }


                // =========================================
                // PINK HANDLE
                // =========================================

                handle: Rectangle {

                    width: 22
                    height: 22

                    radius: 11

                    color:
                        root.deviceOn
                        ? "#FF2E93"
                        : "#9CA3AF"

                    border.color:
                        "white"

                    border.width: 3


                    x:
                        deviceSlider.leftPadding +
                        deviceSlider.visualPosition *
                        (
                            deviceSlider.availableWidth -
                            width
                        )


                    y:
                        deviceSlider.topPadding +
                        deviceSlider.availableHeight / 2 -
                        height / 2
                }
            }
        }
    }
}
