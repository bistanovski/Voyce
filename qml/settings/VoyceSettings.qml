import QtQuick 2.0
import Felgo 3.0
import Qt.labs.settings 1.1

Item {
    id: settingsRoot

    function savePlaylist() {
        var playlistLength = _dataHolder.playlistModelData.count;
        playlistStorage.playlistSize = playlistLength;
        for(var i=0; i < playlistLength; ++i){
            var episodeItem = _dataHolder.playlistModelData.get(i);
            playlistStorage.setValue(i, JSON.stringify(episodeItem));
        }
    }

    function loadSavedPlaylist() {
        for(var i=0; i< playlistStorage.playlistSize; ++i) {
            var episode = playlistStorage.value(i, null);
            if(episode) {
                var parsedEpisode = JSON.parse(episode);
                _dataHolder.playlistModelData.append(parsedEpisode);
                broadcast.addToPlaylist(parsedEpisode)
            }
        }
    }

    function clearPreviousSavedPlaylist() {
        for(var c=0; c < playlistStorage.playlistSize; ++c) {
            var storedItem = playlistStorage.value(c, null);
            if(null === storedItem) {
                break;
            }

            playlistStorage.setValue(c, null)
        }
    }

    function clearPreviousSavedDownloads() {
        for(var c=0; c < downloadsStorage.downloadsSize; ++c) {
            var storedItem = downloadsStorage.value(c, null);
            if(null === storedItem) {
                break;
            }

            downloadsStorage.setValue(c, null)
        }
    }

    function saveDownloads() {
        var downloadsLength = _dataHolder.downloadsModelData.count;
        downloadsStorage.downloadsSize = downloadsLength;
        for(var i=0; i < downloadsLength; ++i){
            var episodeItem = _dataHolder.downloadsModelData.get(i);
            downloadsStorage.setValue(i, JSON.stringify(episodeItem));
        }
    }

    function loadDownloadedEpisodes() {
        for(var i=0; i< downloadsStorage.downloadsSize; ++i) {
            var episode = downloadsStorage.value(i, null);
            if(episode) {
                _dataHolder.downloadsModelData.append(JSON.parse(episode));
            }
        }
    }

    Settings {
        id: playlistStorage
        fileName: "VoycePlaylist.txt"

        property int playlistSize

        Component.onCompleted: {
            loadSavedPlaylist();
        }
    }

    Settings {
        id: downloadsStorage
        fileName: "VoyceDownloads.txt"

        property int downloadsSize

        Component.onCompleted: {
            loadDownloadedEpisodes();
        }
    }

    Settings {
        id: generalSettings
        fileName: "VoyceSettings.txt"
    }
}
