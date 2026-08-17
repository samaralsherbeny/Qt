#include "mediabackend.h"

#include <QFileInfo>

MediaBackend::MediaBackend(QObject *parent)
    : QObject(parent)
{
    m_player = new QMediaPlayer(this);

    m_audioOutput = new QAudioOutput(this);

    m_player->setAudioOutput(m_audioOutput);

    m_audioOutput->setVolume(0.8);

    // =====================================================
    // POSITION
    // =====================================================

    connect(
        m_player,
        &QMediaPlayer::positionChanged,
        this,
        &MediaBackend::positionChanged
        );

    // =====================================================
    // DURATION
    // =====================================================

    connect(
        m_player,
        &QMediaPlayer::durationChanged,
        this,
        &MediaBackend::durationChanged
        );

    // =====================================================
    // PLAYBACK STATE
    // =====================================================

    connect(
        m_player,
        &QMediaPlayer::playbackStateChanged,
        this,
        [this]()
        {
            emit playingChanged();
        }
        );

    // =====================================================
    // VIDEO AVAILABLE
    // =====================================================

    connect(
        m_player,
        &QMediaPlayer::hasVideoChanged,
        this,
        &MediaBackend::hasVideoChanged
        );
}

// =========================================================
// POSITION
// =========================================================

qint64 MediaBackend::position() const
{
    return m_player->position();
}

// =========================================================
// DURATION
// =========================================================

qint64 MediaBackend::duration() const
{
    return m_player->duration();
}

// =========================================================
// VOLUME
// =========================================================

float MediaBackend::volume() const
{
    return m_audioOutput->volume();
}

void MediaBackend::setVolume(float volume)
{
    if (qFuzzyCompare(
            m_audioOutput->volume(),
            volume))
        return;

    m_audioOutput->setVolume(volume);

    emit volumeChanged();
}

// =========================================================
// PLAYING
// =========================================================

bool MediaBackend::playing() const
{
    return m_player->playbackState()
    == QMediaPlayer::PlayingState;
}

// =========================================================
// HAS VIDEO
// =========================================================

bool MediaBackend::hasVideo() const
{
    return m_player->hasVideo();
}

// =========================================================
// CURRENT FILE NAME
// =========================================================

QString MediaBackend::currentFileName() const
{
    return m_currentFileName;
}

// =========================================================
// PLAY
// =========================================================

void MediaBackend::play()
{
    m_player->play();
}

// =========================================================
// PAUSE
// =========================================================

void MediaBackend::pause()
{
    m_player->pause();
}

// =========================================================
// STOP
// =========================================================

void MediaBackend::stop()
{
    m_player->stop();
}

// =========================================================
// SET SOURCE
// =========================================================

void MediaBackend::setSource(const QUrl &url)
{
    m_player->setSource(url);

    QString filePath = url.toLocalFile();

    if (!filePath.isEmpty()) {

        m_currentFileName =
            QFileInfo(filePath).fileName();

    } else {

        m_currentFileName =
            url.toString();
    }

    emit currentFileNameChanged();
}

// =========================================================
// SET POSITION
// =========================================================

void MediaBackend::setPosition(qint64 position)
{
    m_player->setPosition(position);
}

// =========================================================
// SET VIDEO SINK
// =========================================================

void MediaBackend::setVideoSink(QObject *sink)
{
    QVideoSink *videoSink =
        qobject_cast<QVideoSink *>(sink);

    if (!videoSink)
        return;

    m_player->setVideoSink(videoSink);
}
