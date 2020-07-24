import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.12

/*!
    \qmltype VoyceMediaPlayer
    \inherits Rectangle
    \brief VoyceMediaPlayer - simple MediPlayer wrapper.

    VoyceMediaPlayer wraps Qt's MediaPlayer and VoyceMediaControls instances.
*/

Rectangle {
    id: rootControl

    color: "#2D4652"

    /*!
        \qmlproperty alias dispatcher
        Connector for signal handling
    */
    property alias dispatcher: mediaConnection.target

    /*!
        \qmlproperty string episodeUrl
        Holds episode URL scheduled for playing
    */
    property string episodeUrl

    /*!
        \qmlproperty string episodeTitle
        Holds episode title scheduled for playing
    */
    property string episodeTitle

    Connections {
        id: mediaConnection

        onPlayEpisode: {
            rootControl.episodeUrl = episodeData.url
            rootControl.episodeTitle = episodeData.title
            mediaPlayer.play()
        }

        onAddToPlaylist: {
            mediaPlaylist.addItem(episodeData.url)
        }
    }

    Playlist {
        id: mediaPlaylist
        onItemCountChanged: {
            if(itemCount > 0) {
                currentIndex = 0
            }
        }
    }

    MediaPlayer {
        id: mediaPlayer
        source: rootControl.episodeUrl
        playlist: mediaPlaylist
    }

    VoyceMediaControls {
        enabledPrevious: mediaPlayer.playlist && mediaPlayer.playlist.itemCount > 0
        enabledNext: enabledPrevious
        enabledPlayPause: mediaPlayer.hasAudio
    }
}
