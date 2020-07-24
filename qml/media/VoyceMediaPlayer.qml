import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.12

Rectangle {
    id: rootControl

    color: "#b8C8a0"

    property alias dispatcher: mediaConnection.target
    property string episodeUrl
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
