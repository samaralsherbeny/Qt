import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: usbPage

    property StackView stack

    background: Rectangle {
        color: "#0D121B"
    }

    // =====================================================
    // BACKEND STATUS
    // =====================================================

    Connections {
        target: usbBackend

        function onStatusChanged(status) {
            usbStatus.text = status
        }
    }

    // =====================================================
    // BACK BUTTON
    // =====================================================

    Button {
        id: backButton

        text: "← Back"

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 25

        width: 95
        height: 40

        onClicked: {
            usbBackend.stop()
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

    // =====================================================
    // PAGE TITLE
    // =====================================================

    Label {
        anchors.top: parent.top
        anchors.topMargin: 30

        anchors.horizontalCenter: parent.horizontalCenter

        text: "USB"

        color: "white"

        font.pixelSize: 32
        font.bold: true
    }

    // =====================================================
    // USB PANEL
    // =====================================================

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

            spacing: 18

            // =================================================
            // USB TITLE
            // =================================================

            Label {
                text: "USB"

                color: "#C957D9"

                font.pixelSize: 30
                font.bold: true

                Layout.alignment: Qt.AlignHCenter
            }

            // =================================================
            // STATUS
            // =================================================

            Label {
                id: usbStatus

                text: "USB Device Connected"

                color: "#9AA8BD"

                font.pixelSize: 16

                Layout.alignment: Qt.AlignHCenter
            }

            // =================================================
            // FILE AREA
            // =================================================

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

                    // =================================================
                    // FILE DELEGATE
                    // =================================================

                    delegate: Rectangle {

                        width: usbFileList.width

                        height: 65

                        radius: 10

                        color:
                            usbFileList.currentIndex === index
                            ? "#30203A"
                            : "#18212E"

                        border.color:
                            usbFileList.currentIndex === index
                            ? "#C957D9"
                            : "#2B374A"

                        border.width: 1

                        RowLayout {
                            anchors.fill: parent

                            anchors.leftMargin: 18

                            anchors.rightMargin: 18

                            spacing: 15

                            // =========================================
                            // MUSIC ICON
                            // =========================================

                            Image {
                                source: "qrc:/icons/music.png"

                                fillMode:
                                    Image.PreserveAspectFit

                                smooth: true

                                Layout.preferredWidth: 32

                                Layout.preferredHeight: 32

                                Layout.minimumWidth: 32

                                Layout.maximumWidth: 32

                                Layout.alignment:
                                    Qt.AlignVCenter
                            }

                            // =========================================
                            // FILE INFORMATION
                            // =========================================

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
                                }

                                Label {
                                    text: fileType

                                    color: "#8D9AAF"

                                    font.pixelSize: 13
                                }
                            }

                            // =========================================
                            // EMPTY SPACE
                            // =========================================

                            Item {
                                Layout.fillWidth: true
                            }

                            // =========================================
                            // PLAY BUTTON
                            // =========================================

                            Item {

                                Layout.preferredWidth: 40

                                Layout.minimumWidth: 40

                                Layout.maximumWidth: 40

                                Layout.preferredHeight: 40

                                Layout.alignment:
                                    Qt.AlignVCenter

                                Image {

                                    anchors.centerIn: parent

                                    width: 28

                                    height: 28

                                    source:
                                        usbBackend.currentTrackName
                                        === fileName &&
                                        usbBackend.playing
                                        ? "qrc:/icons/pause.png"
                                        : "qrc:/icons/play.png"

                                    fillMode:
                                        Image.PreserveAspectFit

                                    smooth: true
                                }

                                MouseArea {

                                    anchors.fill: parent

                                    onClicked: {

                                        usbFileList.currentIndex =
                                            index

                                        if (
                                            usbBackend.currentTrackName
                                            === fileName
                                        ) {

                                            usbBackend
                                                .togglePlayPause()

                                        } else {

                                            usbBackend.playTrack(
                                                fileName,
                                                filePath
                                            )
                                        }
                                    }
                                }
                            }
                        }

                        // =============================================
                        // SELECT TRACK
                        // =============================================

                        MouseArea {

                            anchors.fill: parent

                            z: -1

                            onClicked: {

                                usbFileList.currentIndex =
                                    index

                                usbStatus.text =
                                    "Selected: " + fileName
                            }
                        }
                    }
                }
            }

            // =================================================
            // CURRENT TRACK
            // =================================================

            Label {

                text:
                    usbBackend.currentTrackName === ""
                    ? "No track selected"
                    : usbBackend.currentTrackName

                color: "white"

                font.pixelSize: 16

                font.bold: true

                Layout.alignment:
                    Qt.AlignHCenter
            }

            // =================================================
            // PREVIOUS / PLAY / NEXT
            // =================================================

            RowLayout {

                Layout.alignment:
                    Qt.AlignHCenter

                spacing: 25

                // =============================================
                // PREVIOUS
                // =============================================

                Button {

                    width: 55

                    height: 45

                    onClicked: {

                        if (
                            usbFileList.currentIndex > 0
                        ) {

                            var previousIndex =
                                usbFileList.currentIndex - 1

                            usbFileList.currentIndex =
                                previousIndex

                            var previousTrack =
                                usbFileList.model.get(
                                    previousIndex
                                )

                            usbBackend.playTrack(
                                previousTrack.fileName,
                                previousTrack.filePath
                            )
                        }
                    }

                    background: Rectangle {

                        radius: 8

                        color:
                            parent.pressed
                            ? "#303B4D"
                            : "#202938"

                        border.color:
                            "#46536A"

                        border.width: 1
                    }

                    contentItem: Text {

                        text: "⏮"

                        color: "white"

                        font.pixelSize: 22

                        horizontalAlignment:
                            Text.AlignHCenter

                        verticalAlignment:
                            Text.AlignVCenter
                    }
                }

                // =============================================
                // PLAY / PAUSE
                // =============================================

                Button {

                    width: 65

                    height: 50

                    onClicked: {

                        if (
                            usbBackend.currentTrackName === ""
                        ) {

                            if (
                                usbFileList.count > 0
                            ) {

                                usbFileList.currentIndex =
                                    0

                                var firstTrack =
                                    usbFileList.model.get(0)

                                usbBackend.playTrack(
                                    firstTrack.fileName,
                                    firstTrack.filePath
                                )
                            }

                        } else {

                            usbBackend.togglePlayPause()
                        }
                    }

                    background: Rectangle {

                        radius: 10

                        color:
                            parent.pressed
                            ? "#A945B8"
                            : "#C957D9"

                        border.color:
                            "#E07AE8"

                        border.width: 1
                    }

                    contentItem: Image {

                        source:
                            usbBackend.playing
                            ? "qrc:/icons/pause.png"
                            : "qrc:/icons/play.png"

                        fillMode:
                            Image.PreserveAspectFit

                        width: 28

                        height: 28
                    }
                }

                // =============================================
                // NEXT
                // =============================================

                Button {

                    width: 55

                    height: 45

                    onClicked: {

                        if (
                            usbFileList.currentIndex
                            < usbFileList.count - 1
                        ) {

                            var nextIndex =
                                usbFileList.currentIndex + 1

                            usbFileList.currentIndex =
                                nextIndex

                            var nextTrack =
                                usbFileList.model.get(
                                    nextIndex
                                )

                            usbBackend.playTrack(
                                nextTrack.fileName,
                                nextTrack.filePath
                            )
                        }
                    }

                    background: Rectangle {

                        radius: 8

                        color:
                            parent.pressed
                            ? "#303B4D"
                            : "#202938"

                        border.color:
                            "#46536A"

                        border.width: 1
                    }

                    contentItem: Text {

                        text: "⏭"

                        color: "white"

                        font.pixelSize: 22

                        horizontalAlignment:
                            Text.AlignHCenter

                        verticalAlignment:
                            Text.AlignVCenter
                    }
                }
            }

            // =================================================
            // POSITION SLIDER
            // =================================================

            RowLayout {

                Layout.fillWidth: true

                spacing: 10

                Label {

                    text:
                        formatTime(
                            usbBackend.position
                        )

                    color: "#9AA8BD"

                    font.pixelSize: 13
                }

                Slider {

                    id: positionSlider

                    Layout.fillWidth: true

                    from: 0

                    to:
                        Math.max(
                            usbBackend.duration,
                            1
                        )

                    value:
                        usbBackend.position

                    onMoved: {

                        usbBackend.setPosition(
                            value
                        )
                    }
                }

                Label {

                    text:
                        formatTime(
                            usbBackend.duration
                        )

                    color: "#9AA8BD"

                    font.pixelSize: 13
                }
            }

            // =================================================
            // VOLUME
            // =================================================

            RowLayout {

                Layout.fillWidth: true

                spacing: 12

                Label {

                    text: "Volume"

                    color: "white"

                    font.pixelSize: 14
                }

                Slider {

                    id: volumeSlider

                    Layout.fillWidth: true

                    from: 0

                    to: 1

                    value:
                        usbBackend.volume

                    onMoved: {

                        usbBackend.volume =
                            value
                    }
                }

                Label {

                    text:
                        Math.round(
                            usbBackend.volume * 100
                        ) + "%"

                    color: "#9AA8BD"

                    font.pixelSize: 14

                    Layout.preferredWidth: 45
                }
            }
        }
    }

    // =====================================================
    // TIME FORMAT FUNCTION
    // =====================================================

    function formatTime(milliseconds) {

        if (milliseconds <= 0)
            return "00:00"

        var totalSeconds =
            Math.floor(
                milliseconds / 1000
            )

        var minutes =
            Math.floor(
                totalSeconds / 60
            )

        var seconds =
            totalSeconds % 60

        return (
            minutes < 10
            ? "0" + minutes
            : minutes
        )
        +
        ":"
        +
        (
            seconds < 10
            ? "0" + seconds
            : seconds
        )
    }
}
