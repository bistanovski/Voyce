import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.12

Playlist {
    id: playlist

    function addEpisode(episodeData) {
        addItem(episodeData.url)
        dataModel.playlistItems.push(episodeData)
    }
}
