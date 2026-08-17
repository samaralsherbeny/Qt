#include "radiostationmodel.h"

RadioStationModel::RadioStationModel(QObject *parent)
    : QAbstractListModel(parent),
    m_player(new QMediaPlayer(this)),
    m_audioOutput(new QAudioOutput(this))
{
    // Connect audio output to media player
    m_player->setAudioOutput(m_audioOutput);

    // Volume
    m_audioOutput->setVolume(1.0);

    // Detect play / pause / stop
    connect(m_player,
            &QMediaPlayer::playbackStateChanged,
            this,
            [this](QMediaPlayer::PlaybackState state)
            {
                bool playing =
                    (state == QMediaPlayer::PlayingState);

                if (m_isPlaying != playing)
                {
                    m_isPlaying = playing;
                    emit isPlayingChanged();
                }
            });


    // =========================
    // RADIO STATIONS
    // =========================

    beginResetModel();

    m_stations.append({
        "Radio Station 1",
        "88.2 FM",
        QUrl("https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one")
    });

    m_stations.append({
        "Radio Station 2",
        "90.9 FM",
        QUrl("https://stream.live.vc.bbcmedia.co.uk/bbc_radio_two")
    });

    m_stations.append({
        "Radio Station 3",
        "92.5 FM",
        QUrl("https://stream.live.vc.bbcmedia.co.uk/bbc_radio_three")
    });

    m_stations.append({
        "Radio Station 4",
        "95.7 FM",
        QUrl("https://stream.live.vc.bbcmedia.co.uk/bbc_radio_fourfm")
    });

    endResetModel();
}


// =========================
// DESTRUCTOR
// =========================

RadioStationModel::~RadioStationModel()
{
    m_player->stop();
}


// =========================
// ROW COUNT
// =========================

int RadioStationModel::rowCount(
    const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_stations.size();
}


// =========================
// DATA
// =========================

QVariant RadioStationModel::data(
    const QModelIndex &index,
    int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 ||
        index.row() >= m_stations.size())
        return QVariant();

    const RadioStation &station =
        m_stations.at(index.row());

    switch (role)
    {
    case StationNameRole:
        return station.name;

    case FrequencyRole:
        return station.frequency;

    case StreamUrlRole:
        return station.streamUrl;

    default:
        return QVariant();
    }
}


// =========================
// ROLE NAMES
// =========================

QHash<int, QByteArray>
RadioStationModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[StationNameRole] = "stationName";
    roles[FrequencyRole] = "frequency";
    roles[StreamUrlRole] = "streamUrl";

    return roles;
}


// =========================
// GETTERS
// =========================

bool RadioStationModel::isPlaying() const
{
    return m_isPlaying;
}


QString RadioStationModel::currentStation() const
{
    return m_currentStation;
}


QString RadioStationModel::currentFrequency() const
{
    return m_currentFrequency;
}


// =========================
// SELECT STATION
// =========================

void RadioStationModel::selectStation(int index)
{
    if (index < 0 ||
        index >= m_stations.size())
        return;

    const RadioStation &station =
        m_stations.at(index);

    m_currentStation = station.name;
    m_currentFrequency = station.frequency;

    emit stationChanged();

    // Set radio stream
    m_player->setSource(station.streamUrl);

    // Start playing
    m_player->play();
}


// =========================
// PLAY / STOP
// =========================

void RadioStationModel::togglePlay()
{
    if (m_player->playbackState() ==
        QMediaPlayer::PlayingState)
    {
        m_player->pause();
    }
    else
    {
        m_player->play();
    }
}
