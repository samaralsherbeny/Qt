import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: radioPage

     property StackView stack
    property string currentStation: "No station selected"
    property string currentFrequency: "-- FM"
    property bool radioPlaying: false

    ListModel {
        id: radioModel

        ListElement {
            stationName: "Radio Station 1"
            frequency: "88.2 FM"
        }

        ListElement {
            stationName: "Radio Station 2"
            frequency: "90.9 FM"
        }

        ListElement {
            stationName: "Radio Station 3"
            frequency: "92.5 FM"
        }

        ListElement {
            stationName: "Radio Station 4"
            frequency: "95.7 FM"
        }
    }

    background: Rectangle {
        color: "#0D121B"
    }

    // =========================
    // BACK BUTTON
    // =========================
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


    // =========================
    // PAGE TITLE
    // =========================
    Label {
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter

        text: "RADIO"

        color: "white"

        font.pixelSize: 32
        font.bold: true
    }


    // =========================
    // RADIO CONTENT
    // =========================
    Rectangle {
        id: radioPanel

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom

        anchors.margins: 25

        radius: 12

        color: "#151D29"

        border.color: "#2B374A"
        border.width: 1


        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30

            spacing: 25


            // Radio icon
            Image {
                source: "qrc:/icons/radio.png"

                width: 60
                height: 60

                fillMode: Image.PreserveAspectFit
                smooth: true

                Layout.alignment: Qt.AlignHCenter
            }
            Label {
                text: currentStation

                color: "white"

                font.pixelSize: 24
                font.bold: true

                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: currentFrequency

                color: "#C957D9"

                font.pixelSize: 18

                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: radioPlaying
                      ? "Playing"
                      : "Select a radio station"

                color: "#9AA8BD"

                font.pixelSize: 15

                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                id: radioControlButton

                Layout.alignment: Qt.AlignHCenter

                Layout.preferredWidth: 120
                Layout.preferredHeight: 45

                text: radioPlaying ? "Stop" : "Play"

                enabled: stationList.currentIndex >= 0

                onClicked: {
                    radioPlaying = !radioPlaying
                }

                background: Rectangle {
                    radius: 10

                    color: radioControlButton.pressed
                           ? "#303B4D"
                           : "#202938"

                    border.color: "#46536A"
                    border.width: 1
                }

                contentItem: Image {
                    anchors.centerIn: parent

                    width: 38
                    height: 38

                    source: radioPlaying
                            ? "qrc:/icons/stop.png"
                            : "qrc:/icons/play.png"

                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }


            // =========================
            // STATION AREA
            // =========================
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: 400

                radius: 10

                color: "#0D121B"

                border.color: "#263247"
                border.width: 1


                ListView {
                    id: stationList

                    anchors.fill: parent

                    anchors.margins: 15

                    model: radioModel

                    spacing: 10

                    clip: true

                    delegate: Rectangle {

                        width: stationList.width

                        height: 65

                        radius: 10

                        color: stationList.currentIndex === index
                               ? "#30203A"
                               : "#18212E"

                        border.color:
                            stationList.currentIndex === index
                            ? "#C957D9"
                            : "#2B374A"

                        border.width: 1


                        RowLayout {

                            anchors.fill: parent

                            anchors.leftMargin: 18
                            anchors.rightMargin: 18

                            spacing: 15


                            Label {

                                text: "◉"

                                color: "#C957D9"

                                font.pixelSize: 20
                            }


                            ColumnLayout {

                                Layout.fillWidth: true

                                spacing: 2


                                Label {

                                    text: stationName

                                    color: "white"

                                    font.pixelSize: 16

                                    font.bold: true
                                }


                                Label {

                                    text: frequency

                                    color: "#8D9AAF"

                                    font.pixelSize: 13
                                }
                            }


                            Label {

                                text: "▶"

                                color: "#C957D9"

                                font.pixelSize: 18
                            }
                        }


                        MouseArea {

                            anchors.fill: parent

                            onClicked: {

                                stationList.currentIndex = index
                                currentStation = stationName
                                currentFrequency = frequency
                                radioPlaying = true
                            }
                        }
                    }
                }
            }
        }
    }
}
