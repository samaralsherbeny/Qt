#ifndef RADIOSTATIONMODEL_H
#define RADIOSTATIONMODEL_H

#include <QAbstractListModel>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QUrl>
#include <QList>

struct RadioStation
{
    QString name;
    QString frequency;
    QUrl streamUrl;
};

class RadioStationModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(bool isPlaying
                   READ isPlaying
                       NOTIFY isPlayingChanged)

    Q_PROPERTY(QString currentStation
                   READ currentStation
                       NOTIFY stationChanged)

    Q_PROPERTY(QString currentFrequency
                   READ currentFrequency
                       NOTIFY stationChanged)

public:

    enum Roles
    {
        StationNameRole = Qt::UserRole + 1,
        FrequencyRole,
        StreamUrlRole
    };

    explicit RadioStationModel(QObject *parent = nullptr);
    ~RadioStationModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index,
                  int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    bool isPlaying() const;
    QString currentStation() const;
    QString currentFrequency() const;

    Q_INVOKABLE void selectStation(int index);
    Q_INVOKABLE void togglePlay();

signals:

    void isPlayingChanged();
    void stationChanged();

private:

    QList<RadioStation> m_stations;

    QMediaPlayer *m_player;
    QAudioOutput *m_audioOutput;

    bool m_isPlaying = false;

    QString m_currentStation = "No station selected";
    QString m_currentFrequency = "-- FM";
};

#endif // RADIOSTATIONMODEL_H
