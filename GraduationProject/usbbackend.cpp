#include "usbbackend.h"

usbbackend::usbbackend(QObject *parent)
    : QObject(parent)
{
    // =====================================================
    // AUDIO OUTPUT
    // =====================================================

    m_player.setAudioOutput(&m_audioOutput);

    m_audioOutput.setVolume(1.0);

    // =====================================================
    // PLAYBACK STATE
    // =====================================================

    connect(
        &m_player,
        &QMediaPlayer::playbackStateChanged,
        this,
        [this](QMediaPlayer::PlaybackState state)
        {
            bool newPlayingState =
                (state == QMediaPlayer::PlayingState);

            if (m_playing != newPlayingState) {

                m_playing = newPlayingState;

                emit playingChanged();
            }

            if (state == QMediaPlayer::PlayingState) {

                emit statusChanged(
                    "Playing: " + m_currentTrackName
                    );

            } else if (state == QMediaPlayer::PausedState) {

                emit statusChanged(
                    "Paused: " + m_currentTrackName
                    );

            } else if (state == QMediaPlayer::StoppedState) {

                emit statusChanged("Stopped");
            }
        }
        );

    // =====================================================
    // POSITION
    // =====================================================

    connect(
        &m_player,
        &QMediaPlayer::positionChanged,
        this,
        [this](qint64 position)
        {
            Q_UNUSED(position)

            emit positionChanged();
        }
        );

    // =====================================================
    // DURATION
    // =====================================================

    connect(
        &m_player,
        &QMediaPlayer::durationChanged,
        this,
        [this](qint64 duration)
        {
            Q_UNUSED(duration)

            emit durationChanged();
        }
        );
}


// =========================================================
// CURRENT TRACK
// =========================================================

QString usbbackend::currentTrackName() const
{
    return m_currentTrackName;
}


// =========================================================
// PLAYING
// =========================================================

bool usbbackend::playing() const
{
    return m_playing;
}


// =========================================================
// VOLUME
// =========================================================

float usbbackend::volume() const
{
    return m_audioOutput.volume();
}

void usbbackend::setVolume(float volume)
{
    if (volume < 0.0f)
        volume = 0.0f;

    if (volume > 1.0f)
        volume = 1.0f;

    if (qFuzzyCompare(
            m_audioOutput.volume(),
            volume))
        return;

    m_audioOutput.setVolume(volume);

    emit volumeChanged();
}


// =========================================================
// POSITION
// =========================================================

qint64 usbbackend::position() const
{
    return m_player.position();
}


// =========================================================
// DURATION
// =========================================================

qint64 usbbackend::duration() const
{
    return m_player.duration();
}


// =========================================================
// PLAY TRACK
// =========================================================

void usbbackend::playTrack(
    const QString &name,
    const QString &path)
{
    m_currentTrackName = name;

    emit currentTrackNameChanged();

    m_player.setSource(QUrl(path));

    m_player.play();
}


// =========================================================
// PLAY / PAUSE
// =========================================================

void usbbackend::togglePlayPause()
{
    if (m_player.playbackState()
        == QMediaPlayer::PlayingState) {

        m_player.pause();

    } else {

        m_player.play();
    }
}


// =========================================================
// STOP
// =========================================================

void usbbackend::stop()
{
    m_player.stop();
}


// =========================================================
// SET POSITION
// =========================================================

void usbbackend::setPosition(qint64 position)
{
    m_player.setPosition(position);
}
