#ifndef MEDIABACKEND_H
#define MEDIABACKEND_H

#include <QObject>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QVideoSink>
#include <QUrl>

class MediaBackend : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qint64 position
                   READ position
                       NOTIFY positionChanged)

    Q_PROPERTY(qint64 duration
                   READ duration
                       NOTIFY durationChanged)

    Q_PROPERTY(float volume
                   READ volume
                       WRITE setVolume
                           NOTIFY volumeChanged)

    Q_PROPERTY(bool playing
                   READ playing
                       NOTIFY playingChanged)

    Q_PROPERTY(bool hasVideo
                   READ hasVideo
                       NOTIFY hasVideoChanged)

    Q_PROPERTY(QString currentFileName
                   READ currentFileName
                       NOTIFY currentFileNameChanged)

public:

    explicit MediaBackend(QObject *parent = nullptr);

    qint64 position() const;

    qint64 duration() const;

    float volume() const;

    void setVolume(float volume);

    bool playing() const;

    bool hasVideo() const;

    QString currentFileName() const;

    Q_INVOKABLE void play();

    Q_INVOKABLE void pause();

    Q_INVOKABLE void stop();

    Q_INVOKABLE void setSource(const QUrl &url);

    Q_INVOKABLE void setPosition(qint64 position);

    Q_INVOKABLE void setVideoSink(QObject *sink);

signals:

    void positionChanged();

    void durationChanged();

    void volumeChanged();

    void playingChanged();

    void hasVideoChanged();

    void currentFileNameChanged();

private:

    QMediaPlayer *m_player;

    QAudioOutput *m_audioOutput;

    QString m_currentFileName;
};

#endif // MEDIABACKEND_H
