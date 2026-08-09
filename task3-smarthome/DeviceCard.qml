import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property string deviceName: ""
    property string imageSource: ""
    property int battery: 100

    width: parent ? parent.width : 400
    height: 125

    radius: 18
    color: "white"

    border.color: deviceSwitch.checked ? "#22D3FF" : "#E5E7EB"
    border.width: 2

    RowLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 18

        // Icon Container
        Rectangle {
            Layout.preferredWidth: 70
            Layout.preferredHeight: 70
            Layout.alignment: Qt.AlignVCenter

            radius: 16
            color: deviceSwitch.checked ? "#F5F7FC" : "#F3F4F6"

            border.color: deviceSwitch.checked ? "#22D3FF" : "#D1D5DB"
            border.width: 2

            Image {
                anchors.fill: parent
                anchors.margins: 6

                source: root.imageSource

                fillMode: Image.PreserveAspectFit
                smooth: false
                opacity: deviceSwitch.checked ? 1.0 : 0.4
            }
        }

        // Information Column
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 5

            Text {
                text: root.deviceName
                color: deviceSwitch.checked ? "#1F2937" : "#9CA3AF"
                font.pixelSize: 20
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            // Dynamic Online/Offline Status Text
            Text {
                text: deviceSwitch.checked ? "🟢 Online" : "🔴 Offline"
                color: deviceSwitch.checked ? "#22C55E" : "#EF4444"
                font.pixelSize: 14
                font.bold: true
            }

            ProgressBar {
                id: control
                Layout.fillWidth: true
                Layout.maximumWidth: 250

                value: root.battery / 100

                background: Rectangle {
                    implicitHeight: 8
                    radius: 4
                    color: "#D6E4F0"
                }

                contentItem: Item {
                    implicitHeight: 8

                    Rectangle {
                        width: control.visualPosition * parent.width
                        height: parent.height
                        radius: 4
                        color: deviceSwitch.checked ? "#22D3FF" : "#9CA3AF"
                    }
                }
            }

            Text {
                text: "Battery: " + root.battery + "%"
                color: "#6B7280"
                font.pixelSize: 14
            }
        }

        // Dynamic Toggle Switch
        Switch {
            id: deviceSwitch
            Layout.alignment: Qt.AlignVCenter
            checked: true

            onCheckedChanged: {
                console.log(root.deviceName + (checked ? " ON" : " OFF"))
            }
        }
    }
}
