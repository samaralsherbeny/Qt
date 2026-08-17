import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia

Page {
    id: localMediaPage

    property StackView stack

    // =========================================================
    // PLAYLIST
    // =========================================================

    ListModel {
        id: playlistModel
    }

    // =========================================================
    // FUNCTIONS
    // =========================================================

    function formatTime(milliseconds) {

        if (milliseconds <= 0)
            return "00:00"

        var totalSeconds =
            Math.floor(milliseconds / 1000)

        var minutes =
            Math.floor(totalSeconds / 60)

        var seconds =
            totalSeconds % 60

        return (minutes < 10 ? "0" : "")
                + minutes
                + ":"
                + (seconds < 10 ? "0" : "")
                + seconds
    }

    function playCurrentItem() {

        if (playlistView.currentIndex < 0 ||
            playlistView.currentIndex >= playlistModel.count)
            return

        var item =
            playlistModel.get(
                playlistView.currentIndex
            )

        mediaBackend.setSource(
            item.fileUrl
        )

        currentMediaLabel.text =
            item.fileName

        mediaBackend.play()
    }

    // =========================================================
    // FILE DIALOG
    // =========================================================

    FileDialog {
        id: fileDialog

        title: "Select Media Files"

        fileMode:
            FileDialog.OpenFiles

        nameFilters: [
            "Media files (*.mp3 *.wav *.ogg *.mp4 *.mkv *.avi)",
            "Audio files (*.mp3 *.wav *.ogg)",
            "Video files (*.mp4 *.mkv *.avi)"
        ]

        onAccepted: {

            for (
                var i = 0;
                i < selectedFiles.length;
                i++
            ) {

                var file =
                    selectedFiles[i]

                playlistModel.append({
                    "fileName":
                        file.toString()
                        .split("/")
                        .pop(),

                    "fileUrl":
                        file
                })
            }

            if (
                playlistModel.count > 0 &&
                playlistView.currentIndex < 0
            ) {
                playlistView.currentIndex = 0
            }
        }
    }

    // =========================================================
    // BACKGROUND
    // =========================================================

    background: Rectangle {
        color: "#0D121A"
    }

    // =========================================================
    // MAIN LAYOUT
    // =========================================================

    ColumnLayout {

        anchors.fill: parent
        anchors.margins: 28

        spacing: 18

        // =====================================================
        // HEADER
        // =====================================================

        RowLayout {

            Layout.fillWidth: true
            Layout.preferredHeight: 55

            Button {

                text: "←  Back"

                Layout.preferredWidth: 110
                Layout.preferredHeight: 45

                font.pixelSize: 16

                onClicked: {
                    stack.pop()
                }

                background: Rectangle {

                    radius: 10

                    color:
                        parent.pressed
                        ? "#394354"
                        : "#202938"

                    border.color: "#4A5568"
                    border.width: 1
                }

                contentItem: Text {

                    text: parent.text

                    color: "white"

                    font.pixelSize: 16

                    horizontalAlignment:
                        Text.AlignHCenter

                    verticalAlignment:
                        Text.AlignVCenter
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Label {

                text: "LOCAL MEDIA"

                color: "white"

                font.pixelSize: 30
                font.bold: true

                Layout.alignment:
                    Qt.AlignCenter
            }

            Item {
                Layout.fillWidth: true
            }

            Item {
                Layout.preferredWidth: 110
            }
        }

        // =====================================================
        // MEDIA DISPLAY
        // =====================================================

        Rectangle {

            Layout.fillWidth: true
            Layout.preferredHeight: 300

            radius: 16

            color: "#151C27"

            border.color: "#2C3748"
            border.width: 1

            VideoOutput {

                id: videoOutput

                anchors.fill: parent

                anchors.margins: 2

                visible:
                    mediaBackend.hasVideo

                Component.onCompleted: {

                    mediaBackend.setVideoSink(
                        videoOutput.videoSink
                    )
                }
            }

            Column {

                anchors.centerIn: parent

                spacing: 12

                visible:
                    !mediaBackend.hasVideo

                Label {

                    text: "♫"

                    color: "#C957D9"

                    font.pixelSize: 60

                    anchors.horizontalCenter:
                        parent.horizontalCenter
                }

                Label {

                    text:
                        mediaBackend.currentFileName === ""
                        ? "No media playing"
                        : "Now Playing"

                    color: "#AEB7C5"

                    font.pixelSize: 20

                    anchors.horizontalCenter:
                        parent.horizontalCenter
                }
            }
        }

        // =====================================================
        // CURRENT MEDIA
        // =====================================================

        Label {

            id: currentMediaLabel

            text: "No media selected"

            color: "white"

            font.pixelSize: 18
            font.bold: true

            Layout.fillWidth: true

            horizontalAlignment:
                Text.AlignHCenter

            elide:
                Text.ElideMiddle
        }

        // =====================================================
        // PLAYLIST + VOLUME
        // =====================================================

        RowLayout {

            Layout.fillWidth: true
            Layout.fillHeight: true

            spacing: 18

            // =================================================
            // PLAYLIST
            // =================================================

            Rectangle {

                Layout.fillWidth: true
                Layout.fillHeight: true

                radius: 14

                color: "#171F2C"

                border.color: "#2C3748"
                border.width: 1

                ColumnLayout {

                    anchors.fill: parent
                    anchors.margins: 18

                    spacing: 12

                    RowLayout {

                        Layout.fillWidth: true

                        Label {

                            text: "Playlist"

                            color: "white"

                            font.pixelSize: 22
                            font.bold: true

                            Layout.fillWidth: true
                        }

                        Button {

                            text: "+ Add Media"

                            Layout.preferredWidth: 130
                            Layout.preferredHeight: 38

                            onClicked: {
                                fileDialog.open()
                            }

                            background:
                                Rectangle {

                                radius: 8

                                color:
                                    parent.pressed
                                    ? "#A73BB8"
                                    : "#C957D9"
                            }

                            contentItem: Text {

                                text: parent.text

                                color: "white"

                                font.pixelSize: 14

                                horizontalAlignment:
                                    Text.AlignHCenter

                                verticalAlignment:
                                    Text.AlignVCenter
                            }
                        }
                    }

                    // =========================================
                    // PLAYLIST VIEW
                    // =========================================

                    Rectangle {

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        radius: 10

                        color: "#0E141D"

                        ListView {

                            id: playlistView

                            anchors.fill: parent

                            anchors.margins: 6

                            model:
                                playlistModel

                            clip: true

                            spacing: 4

                            delegate: Rectangle {

                                width:
                                    playlistView.width

                                height: 48

                                radius: 8

                                color:
                                    ListView.isCurrentItem
                                    ? "#3A2342"
                                    : "#18202B"

                                border.color:
                                    ListView.isCurrentItem
                                    ? "#C957D9"
                                    : "transparent"

                                Text {

                                    anchors.left:
                                        parent.left

                                    anchors.leftMargin: 15

                                    anchors.right:
                                        parent.right

                                    anchors.rightMargin: 10

                                    anchors.verticalCenter:
                                        parent.verticalCenter

                                    text:
                                        fileName

                                    color:
                                        ListView.isCurrentItem
                                        ? "#FFFFFF"
                                        : "#C4CBD5"

                                    font.pixelSize: 15

                                    elide:
                                        Text.ElideMiddle
                                }

                                MouseArea {

                                    anchors.fill:
                                        parent

                                    onClicked: {

                                        playlistView.currentIndex =
                                            index

                                        playCurrentItem()
                                    }
                                }
                            }

                            Label {

                                anchors.centerIn:
                                    parent

                                visible:
                                    playlistModel.count === 0

                                text:
                                    "No media loaded"

                                color:
                                    "#697586"

                                font.pixelSize: 16
                            }
                        }
                    }
                }
            }

            // =================================================
            // VOLUME
            // =================================================

            Rectangle {

                Layout.preferredWidth: 190
                Layout.fillHeight: true

                radius: 14

                color: "#171F2C"

                border.color: "#2C3748"
                border.width: 1

                Column {

                    anchors.centerIn: parent

                    spacing: 15

                    Label {

                        text: "Volume"

                        color: "white"

                        font.pixelSize: 20
                        font.bold: true

                        anchors.horizontalCenter:
                            parent.horizontalCenter
                    }

                    Label {

                        text: "🔊"

                        font.pixelSize: 32

                        anchors.horizontalCenter:
                            parent.horizontalCenter
                    }

                    Slider {

                        id: volumeSlider

                        from: 0
                        to: 1

                        value:
                            mediaBackend.volume

                        width: 140

                        anchors.horizontalCenter:
                            parent.horizontalCenter

                        onMoved: {

                            mediaBackend.volume =
                                value
                        }
                    }

                    Label {

                        text:
                            Math.round(
                                volumeSlider.value * 100
                            ) + "%"

                        color: "#C957D9"

                        font.pixelSize: 16

                        anchors.horizontalCenter:
                            parent.horizontalCenter
                    }
                }
            }
        }

        // =====================================================
        // PROGRESS
        // =====================================================

        RowLayout {

            Layout.fillWidth: true

            spacing: 10

            Label {

                text:
                    formatTime(
                        mediaBackend.position
                    )

                color: "#AEB7C5"

                font.pixelSize: 13
            }

            Slider {

                id: progressSlider

                Layout.fillWidth: true

                from: 0

                to:
                    mediaBackend.duration > 0
                    ? mediaBackend.duration
                    : 1

                value:
                    mediaBackend.position

                onMoved: {

                    mediaBackend.setPosition(
                        value
                    )
                }
            }

            Label {

                text:
                    formatTime(
                        mediaBackend.duration
                    )

                color: "#AEB7C5"

                font.pixelSize: 13
            }
        }

        // =====================================================
        // PLAYBACK CONTROLS
        // =====================================================

        Row {

            anchors.horizontalCenter:
                parent.horizontalCenter

            spacing:
                Math.max(
                    20,
                    Math.min(
                        parent.width * 0.025,
                        45
                    )
                )

            // =================================================
            // PREVIOUS
            // =================================================

            MediaButton {

                iconSource:
                    "qrc:/icons/prev.png"

                buttonSize: 64
                iconSize: 38

                onClicked: {

                    if (
                        playlistView.currentIndex > 0
                    ) {

                        playlistView.currentIndex--

                        playCurrentItem()
                    }
                }
            }

            // =================================================
            // PLAY / PAUSE
            // =================================================

            MediaButton {

                iconSource:
                    mediaBackend.playing
                    ? "qrc:/icons/pause.png"
                    : "qrc:/icons/play.png"

                buttonSize: 72
                iconSize: 40

                anchors.verticalCenter:
                    parent.children[0].verticalCenter

                onClicked: {

                    if (mediaBackend.playing) {

                        mediaBackend.pause()

                    } else {

                        mediaBackend.play()
                    }
                }
            }

            // =================================================
            // STOP
            // =================================================

            MediaButton {

                iconSource:
                    "qrc:/icons/stop.png"

                buttonSize: 64
                iconSize: 36

                anchors.verticalCenter:
                    parent.children[0].verticalCenter

                onClicked: {

                    mediaBackend.stop()
                }
            }

            // =================================================
            // NEXT
            // =================================================

            MediaButton {

                iconSource:
                    "qrc:/icons/next.png"

                buttonSize: 64
                iconSize: 38

                anchors.verticalCenter:
                    parent.children[0].verticalCenter

                onClicked: {

                    if (
                        playlistView.currentIndex <
                        playlistModel.count - 1
                    ) {

                        playlistView.currentIndex++

                        playCurrentItem()
                    }
                }
            }
        }
    }
}
