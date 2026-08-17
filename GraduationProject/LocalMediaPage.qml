import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia

Page {
    id: localMediaPage

    property StackView stack

    // =========================================================
    // PLAYLIST MODEL
    // =========================================================

    ListModel {
        id: playlistModel
    }

    // =========================================================
    // MEDIA PLAYER
    // =========================================================

    MediaPlayer {
        id: mediaPlayer

        audioOutput: AudioOutput {
            id: audioOutput
            volume: volumeSlider.value
        }

        videoOutput: videoOutput
    }

    // =========================================================
    // FUNCTIONS
    // =========================================================

    function formatTime(milliseconds) {
        if (milliseconds <= 0)
            return "00:00"

        var totalSeconds = Math.floor(milliseconds / 1000)

        var minutes = Math.floor(totalSeconds / 60)
        var seconds = totalSeconds % 60

        return (minutes < 10 ? "0" : "") + minutes
                + ":"
                + (seconds < 10 ? "0" : "") + seconds
    }

    function playCurrentItem() {

        if (playlistView.currentIndex < 0 ||
            playlistView.currentIndex >= playlistModel.count)
            return

        var item = playlistModel.get(playlistView.currentIndex)

        mediaPlayer.source = item.fileUrl

        currentMediaLabel.text = item.fileName

        mediaPlayer.play()
    }

    // =========================================================
    // FILE DIALOG
    // =========================================================

    FileDialog {
        id: fileDialog

        title: "Select Media Files"

        fileMode: FileDialog.OpenFiles

        nameFilters: [
            "Media files (*.mp3 *.wav *.ogg *.mp4 *.mkv *.avi)",
            "Audio files (*.mp3 *.wav *.ogg)",
            "Video files (*.mp4 *.mkv *.avi)"
        ]

        onAccepted: {

            for (var i = 0; i < selectedFiles.length; i++) {

                var file = selectedFiles[i]

                playlistModel.append({
                    "fileName": file.toString().split("/").pop(),
                    "fileUrl": file
                })
            }

            if (playlistModel.count > 0 &&
                playlistView.currentIndex < 0) {

                playlistView.currentIndex = 0
            }
        }
    }

    // =========================================================
    // PAGE BACKGROUND
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

            // Back button

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
                    color: parent.pressed
                           ? "#394354"
                           : "#202938"

                    border.color: "#4A5568"
                    border.width: 1
                }

                contentItem: Text {
                    text: parent.text

                    color: "white"

                    font.pixelSize: 16

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
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

                Layout.alignment: Qt.AlignCenter
            }

            Item {
                Layout.fillWidth: true
            }

            // Invisible item to keep title centered

            Item {
                Layout.preferredWidth: 110
            }
        }

        // =====================================================
        // MEDIA DISPLAY AREA
        // =====================================================

        Rectangle {

            Layout.fillWidth: true
            Layout.preferredHeight: 300

            radius: 16

            color: "#151C27"

            border.color: "#2C3748"
            border.width: 1

            // Video output

            VideoOutput {
                id: videoOutput

                anchors.fill: parent

                anchors.margins: 2

                visible: mediaPlayer.hasVideo
            }

            // Shown when there is no video

            Column {

                anchors.centerIn: parent

                spacing: 12

                visible: !mediaPlayer.hasVideo

                Label {
                    text: "♫"

                    color: "#C957D9"

                    font.pixelSize: 60

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    text: mediaPlayer.source === ""
                          ? "No media playing"
                          : "Now Playing"

                    color: "#AEB7C5"

                    font.pixelSize: 20

                    anchors.horizontalCenter: parent.horizontalCenter
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

            horizontalAlignment: Text.AlignHCenter

            elide: Text.ElideMiddle
        }

        // =====================================================
        // PLAYLIST + VOLUME
        // =====================================================

        RowLayout {

            Layout.fillWidth: true
            Layout.fillHeight: true

            spacing: 18

            // =================================================
            // PLAYLIST PANEL
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

                            background: Rectangle {

                                radius: 8

                                color: parent.pressed
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

                    // Playlist

                    Rectangle {

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        radius: 10

                        color: "#0E141D"

                        ListView {

                            id: playlistView

                            anchors.fill: parent

                            anchors.margins: 6

                            model: playlistModel

                            clip: true

                            spacing: 4

                            delegate: Rectangle {

                                width: playlistView.width
                                height: 48

                                radius: 8

                                color: ListView.isCurrentItem
                                       ? "#3A2342"
                                       : "#18202B"

                                border.color:
                                    ListView.isCurrentItem
                                    ? "#C957D9"
                                    : "transparent"

                                Text {

                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    anchors.right: parent.right
                                    anchors.rightMargin: 10

                                    anchors.verticalCenter:
                                        parent.verticalCenter

                                    text: fileName

                                    color: ListView.isCurrentItem
                                           ? "#FFFFFF"
                                           : "#C4CBD5"

                                    font.pixelSize: 15

                                    elide: Text.ElideMiddle
                                }

                                MouseArea {

                                    anchors.fill: parent

                                    onClicked: {

                                        playlistView.currentIndex =
                                            index

                                        playCurrentItem()
                                    }
                                }
                            }

                            Label {

                                anchors.centerIn: parent

                                visible:
                                    playlistModel.count === 0

                                text: "No media loaded"

                                color: "#697586"

                                font.pixelSize: 16
                            }
                        }
                    }
                }
            }

            // =================================================
            // VOLUME PANEL
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

                        value: 0.8

                        width: 140

                        anchors.horizontalCenter:
                            parent.horizontalCenter
                    }

                    Label {

                        text: Math.round(
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
        // PROGRESS BAR
        // =====================================================

        RowLayout {

            Layout.fillWidth: true

            spacing: 10

            Label {

                text: formatTime(mediaPlayer.position)

                color: "#AEB7C5"

                font.pixelSize: 13
            }

            Slider {

                id: progressSlider

                Layout.fillWidth: true

                from: 0

                to: mediaPlayer.duration > 0
                    ? mediaPlayer.duration
                    : 1

                value: mediaPlayer.position

                onMoved: {
                    mediaPlayer.setPosition(value)
                }
            }

            Label {

                text: formatTime(mediaPlayer.duration)

                color: "#AEB7C5"

                font.pixelSize: 13
            }
        }

        // =====================================================
        // PLAYBACK CONTROLS
        // =====================================================

        Row {
            id: playbackControls

            anchors.horizontalCenter: parent.horizontalCenter

            // Dynamic spacing based on the available width
            spacing: Math.max(20, Math.min(parent.width * 0.025, 45))

            // PREVIOUS
            Button {
                id: previousButton

                width: 64
                height: 64

                onClicked: {
                    if (playlistView.currentIndex > 0) {
                        playlistView.currentIndex--
                        playCurrentItem()
                    }
                }

                background: Rectangle {
                    anchors.fill: parent

                    radius: width / 2

                    color: previousButton.pressed
                           ? "#303B4D"
                           : "#202938"

                    border.color: "#46536A"
                    border.width: 1
                }

                contentItem: Image {
                    anchors.centerIn: parent

                    width: 38
                    height: 38

                    source: "qrc:/icons/prev.png"

                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }


            // PLAY / PAUSE
            Button {
                id: playButton

                width: 72
                height: 72

                anchors.verticalCenter: previousButton.verticalCenter

                onClicked: {
                    if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                        mediaPlayer.pause()
                    } else {
                        mediaPlayer.play()
                    }
                }

                background: Rectangle {
                    anchors.fill: parent

                    radius: width / 2

                    color: playButton.pressed
                           ? "#303B4D"
                           : "#202938"

                    border.color: "#46536A"
                    border.width: 1
                }

                contentItem: Image {
                    anchors.centerIn: parent

                    width: 40
                    height: 40

                    source: mediaPlayer.playbackState === MediaPlayer.PlayingState
                            ? "qrc:/icons/pause.png"
                            : "qrc:/icons/play.png"

                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }


            // STOP
            Button {
                id: stopButton

                width: 64
                height: 64

                anchors.verticalCenter: previousButton.verticalCenter

                onClicked: {
                    mediaPlayer.stop()
                }

                background: Rectangle {
                    anchors.fill: parent

                    radius: width / 2

                    color: stopButton.pressed
                           ? "#303B4D"
                           : "#202938"

                    border.color: "#46536A"
                    border.width: 1
                }

                contentItem: Image {
                    anchors.centerIn: parent

                    width: 36
                    height: 36

                    source: "qrc:/icons/stop.png"

                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }


            // NEXT
            Button {
                id: nextButton

                width: 64
                height: 64

                anchors.verticalCenter: previousButton.verticalCenter

                onClicked: {
                    if (playlistView.currentIndex <
                            playlistModel.count - 1) {

                        playlistView.currentIndex++
                        playCurrentItem()
                    }
                }

                background: Rectangle {
                    anchors.fill: parent

                    radius: width / 2

                    color: nextButton.pressed
                           ? "#303B4D"
                           : "#202938"

                    border.color: "#46536A"
                    border.width: 1
                }

                contentItem: Image {
                    anchors.centerIn: parent

                    width: 38
                    height: 38

                    source: "qrc:/icons/next.png"

                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }
        }
    }

    // =========================================================
    //  PROGRESS SLIDER
    // =========================================================

    Connections {

        target: mediaPlayer

        function onPositionChanged() {

            if (!progressSlider.pressed) {

                progressSlider.value =
                    mediaPlayer.position
            }
        }
    }
}
