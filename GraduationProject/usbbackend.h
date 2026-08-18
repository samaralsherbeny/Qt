#ifndef USBBACKEND_H
#define USBBACKEND_H

#include <QObject>
#include <QMediaPlayer>
#include <QAudioOutput>

class usbbackend : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString currentTrackName
                   READ currentTrackName
                       NOTIFY currentTrackNameChanged)

    Q_PROPERTY(bool playing
                   READ playing
                       NOTIFY playingChanged)

    Q_PROPERTY(float volume
                   READ volume
                       WRITE setVolume
                           NOTIFY volumeChanged)

    Q_PROPERTY(qint64 position
                   READ position
                       NOTIFY positionChanged)

    Q_PROPERTY(qint64 duration
                   READ duration
                       NOTIFY durationChanged)

public:
    explicit usbbackend(QObject *parent = nullptr);

    QString currentTrackName() const;
    bool playing() const;

    float volume() const;
    void setVolume(float volume);

    qint64 position() const;
    qint64 duration() const;

    Q_INVOKABLE void playTrack(
        const QString &name,
        const QString &path
        );

    Q_INVOKABLE void togglePlayPause();

    Q_INVOKABLE void stop();

    Q_INVOKABLE void setPosition(qint64 position);

signals:
    void currentTrackNameChanged();
    void playingChanged();
    void volumeChanged();
    void positionChanged();
    void durationChanged();
    void statusChanged(const QString &status);

private:
    QMediaPlayer m_player;
    QAudioOutput m_audioOutput;

    QString m_currentTrackName;

    bool m_playing = false;
};

#endif
