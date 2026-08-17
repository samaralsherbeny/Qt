import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Page {
    id: radioPage

    property StackView stack

    property string currentStation: "No station selected"
    property string currentFrequency: "-- FM"
    property bool radioPlaying: false

    background: Rectangle {
        color: "#0D121B"
    }

    // =========================================
    // REAL RADIO PLAYER
    // =========================================

    MediaPlayer {
        id: radioPlayer

        audioOutput: AudioOutput {
            id: audioOutput
            volume: 1.0
        }

        onPlaybackStateChanged: {
            if (playbackState === MediaPlayer.PlayingState) {
                radioPlaying = true
            } else if (playbackState === MediaPlayer.PausedState) {
                radioPlaying = false
            } else if (playbackState === MediaPlayer.StoppedState) {
                radioPlaying = false
            }
        }

        onErrorOccurred: function(error, errorString) {
            radioPlaying = false
            radioStatus.text = "Error: " + errorString
        }
    }

    // =========================================
    // REAL RADIO STATIONS
    // =========================================

    ListModel {
        id: radioModel

        ListElement {
            stationName: "Radio 9090"
            frequency: "90.9 FM"
            streamUrl: "http://9090streaming.mobtada.com/9090FMEGYPT"
        }

        ListElement {
            stationName: "Mix FM"
            frequency: "87.8 FM"
            streamUrl: "https://stream-29.zeno.fm/na3vpvn10qruv"
        }

        ListElement {
            stationName: "On Sport FM"
            frequency: "93.7 FM"
            streamUrl: "https://carina.streamerr.co:2020/stream/OnSportFM"
        }

        ListElement {
            stationName: "Arab Mix Drama"
            frequency: "Online"
            streamUrl: "https://stream.zeno.fm/egynebf171zuv.acc"
        }
    }

    // =========================================
    // BACK BUTTON
    // =========================================

    Button {
        id: backButton

        text: "← Back"

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 25

        width: 95
        height: 40

        onClicked: {
            radioPlayer.stop()
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

    // =========================================
    // PAGE TITLE
    // =========================================

    Label {
        anchors.top: parent.top
        anchors.topMargin: 30

        anchors.horizontalCenter: parent.horizontalCenter

        text: "RADIO"

        color: "white"

        font.pixelSize: 32
        font.bold: true
    }

    // =========================================
    // RADIO PANEL
    // =========================================

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
            spacing: 20

            // =========================================
            // RADIO ICON
            // =========================================

            Image {
                source: "qrc:/icons/radio.png"

                width: 60
                height: 60

                fillMode: Image.PreserveAspectFit
                smooth: true

                Layout.alignment: Qt.AlignHCenter
            }

            // =========================================
            // CURRENT STATION
            // =========================================

            Label {
                text: currentStation

                color: "white"

                font.pixelSize: 24
                font.bold: true

                Layout.alignment: Qt.AlignHCenter
            }

            // =========================================
            // FREQUENCY
            // =========================================

            Label {
                text: currentFrequency

                color: "#C957D9"

                font.pixelSize: 18

                Layout.alignment: Qt.AlignHCenter
            }

            // =========================================
            // STATUS
            // =========================================

            Label {
                id: radioStatus

                text: radioPlaying
                      ? "Playing Live"
                      : "Select a radio station"

                color: "#9AA8BD"

                font.pixelSize: 15

                Layout.alignment: Qt.AlignHCenter
            }

            // =========================================
            // PLAY / STOP BUTTON
            // =========================================

            Button {
                id: radioControlButton

                Layout.alignment: Qt.AlignHCenter

                Layout.preferredWidth: 120
                Layout.preferredHeight: 45

                text: radioPlaying ? "Stop" : "Play"

                enabled: stationList.currentIndex >= 0

                onClicked: {
                    if (radioPlaying) {
                        radioPlayer.stop()
                        radioStatus.text = "Stopped"
                    } else {
                        radioPlayer.play()
                        radioStatus.text = "Connecting..."
                    }
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

            // =========================================
            // STATION LIST
            // =========================================

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

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

                    // =========================================
                    // STATION DELEGATE
                    // =========================================

                    delegate: Rectangle {
                        width: stationList.width
                        height: 70
                        radius: 10

                        color: stationList.currentIndex === index
                               ? "#30203A"
                               : "#18212E"

                        border.color: stationList.currentIndex === index
                                      ? "#C957D9"
                                      : "#2B374A"
                        border.width: 1

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 18
                            anchors.rightMargin: 18
                            spacing: 15

                            // RADIO ICON
                            Label {
                                text: "◉"
                                color: "#C957D9"
                                font.pixelSize: 20
                                Layout.alignment: Qt.AlignVCenter
                            }

                            // STATION INFORMATION
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Label {
                                    text: stationName
                                    color: "white"
                                    font.pixelSize: 16
                                    font.bold: true
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillWidth: true
                                }

                                Label {
                                    text: frequency
                                    color: "#8D9AAF"
                                    font.pixelSize: 13
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillWidth: true
                                }
                            }

                            // PLAY / STOP ICON
                            Item {
                                Layout.preferredWidth: 30
                                Layout.preferredHeight: 30
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                                Label {
                                    anchors.centerIn: parent
                                    text: stationList.currentIndex === index && radioPlaying
                                          ? "■"
                                          : "▶"
                                    color: "#C957D9"
                                    font.pixelSize: 18
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }

                        // =========================================
                        // SELECT STATION
                        // =========================================

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                stationList.currentIndex = index

                                currentStation = stationName
                                currentFrequency = frequency

                                radioPlayer.stop()
                                radioPlayer.source = streamUrl
                                radioStatus.text = "Connecting to " + stationName
                                radioPlayer.play()
                            }
                        }
                    }
                }
            }
        }
    }
}
