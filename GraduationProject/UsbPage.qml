import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Page {
    id: usbPage

    property StackView stack
    property string currentTrackName: ""
    property bool isPlaying: false

    background: Rectangle {
        color: "#0D121B"
    }

    // =========================
    // MEDIA PLAYER
    // =========================
    MediaPlayer {
        id: mediaPlayer

        audioOutput: AudioOutput {
            id: audioOutput
            volume: 1.0
        }

        onPlaybackStateChanged: {

            if (playbackState === MediaPlayer.PlayingState) {
                isPlaying = true
                usbStatus.text = "Playing: " + currentTrackName

            } else if (playbackState === MediaPlayer.PausedState) {
                isPlaying = false
                usbStatus.text = "Paused: " + currentTrackName

            } else if (playbackState === MediaPlayer.StoppedState) {
                isPlaying = false
                usbStatus.text = "Stopped"
            }
        }
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
            mediaPlayer.stop()
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

        text: "USB"

        color: "white"

        font.pixelSize: 32
        font.bold: true
    }


    // =========================
    // USB CONTENT
    // =========================
    Rectangle {
        id: usbPanel

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


            // =========================
            // USB TITLE
            // =========================
            Label {
                text: "USB"

                color: "#C957D9"

                font.pixelSize: 30
                font.bold: true

                Layout.alignment: Qt.AlignHCenter
            }


            // =========================
            // STATUS
            // =========================
            Label {
                id: usbStatus

                text: "USB Device Connected"

                color: "#9AA8BD"

                font.pixelSize: 16

                Layout.alignment: Qt.AlignHCenter
            }


            // =========================
            // FILE AREA
            // =========================
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

                radius: 10

                color: "#0D121B"

                border.color: "#263247"
                border.width: 1


                ListView {
                    id: usbFileList

                    anchors.fill: parent

                    anchors.margins: 15

                    spacing: 10

                    clip: true


                    // =========================
                    // USB FILE MODEL
                    // =========================
                    model: ListModel {

                        ListElement {
                            fileName: "Khatfony"
                            fileType: "Audio"
                            filePath: "qrc:/audio/khatfony.mp3"
                        }

                        ListElement {
                            fileName: "Ray'a"
                            fileType: "Audio"
                            filePath: "qrc:/audio/ray'a.mp3"
                        }

                        ListElement {
                            fileName: "Tamally maak"
                            fileType: "Audio"
                            filePath: "qrc:/audio/tamallymaak.mp3"
                        }
                    }


                    // =========================
                    // FILE DELEGATE
                    // =========================
                    delegate: Rectangle {

                        width: usbFileList.width
                        height: 65

                        radius: 10

                        color: usbFileList.currentIndex === index
                               ? "#30203A"
                               : "#18212E"

                        border.color:
                            usbFileList.currentIndex === index
                            ? "#C957D9"
                            : "#2B374A"

                        border.width: 1


                        // =========================
                        // ROW CONTENT
                        // =========================
                        RowLayout {
                            anchors.fill: parent

                            anchors.leftMargin: 18
                            anchors.rightMargin: 18

                            spacing: 15

                            // =========================
                            // MUSIC ICON
                            // =========================
                            Image {
                                source: "qrc:/icons/music.png"

                                fillMode: Image.PreserveAspectFit
                                smooth: true

                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                Layout.minimumWidth: 32
                                Layout.maximumWidth: 32

                                Layout.alignment: Qt.AlignVCenter
                            }


                            // =========================
                            // FILE INFORMATION
                            // =========================
                            ColumnLayout {
                                Layout.preferredWidth: 600
                                Layout.minimumWidth: 600
                                Layout.maximumWidth: 600

                                spacing: 2

                                Label {
                                    text: fileName

                                    color: "white"

                                    font.pixelSize: 16
                                    font.bold: true

                                    Layout.alignment: Qt.AlignLeft
                                }

                                Label {
                                    text: fileType

                                    color: "#8D9AAF"

                                    font.pixelSize: 13

                                    Layout.alignment: Qt.AlignLeft
                                }
                            }


                            // =========================
                            // EMPTY SPACE
                            // =========================
                            Item {
                                Layout.fillWidth: true
                            }


                            // =========================
                            // PLAY BUTTON
                            // =========================
                            Item {
                                id: playButton

                                Layout.preferredWidth: 40
                                Layout.minimumWidth: 40
                                Layout.maximumWidth: 40

                                Layout.preferredHeight: 40
                                Layout.alignment: Qt.AlignVCenter

                                Image {
                                    anchors.centerIn: parent

                                    width: 28
                                    height: 28

                                    source: currentTrackName === fileName &&
                                            mediaPlayer.playbackState === MediaPlayer.PlayingState
                                            ? "qrc:/icons/pause.png"
                                            : "qrc:/icons/play.png"

                                    fillMode: Image.PreserveAspectFit
                                    smooth: true
                                }

                                MouseArea {
                                    anchors.fill: parent

                                    onClicked: {

                                        usbFileList.currentIndex = index

                                        // If this is the currently selected song
                                        if (currentTrackName === fileName) {

                                            if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                                                mediaPlayer.pause()
                                            }
                                            else {
                                                mediaPlayer.play()
                                            }

                                        }
                                        // If it is a different song
                                        else {

                                            currentTrackName = fileName

                                            mediaPlayer.source = filePath
                                            mediaPlayer.play()
                                        }
                                    }
                                }
                            }
                        }


                        // =========================
                        // SELECT TRACK
                        // =========================
                        MouseArea {
                            anchors.fill: parent

                            // Keep the play button clickable
                            z: -1

                            onClicked: {
                                usbFileList.currentIndex = index

                                usbStatus.text =
                                    "Selected: " + fileName
                            }
                        }
                    }
                }
            }
        }
    }
}
