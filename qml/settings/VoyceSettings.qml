import QtQuick 2.0
import Felgo 3.0
import Qt.labs.settings 1.1

/*!
    \qmltype VoyceSettings
    \inherits Item
    \brief VoyceSettings - basic local Settings storage.

    VoyceSettings is a simple component which uses Qt's \b{Settings} components
    in order to save playlist and downloaded episode items, so they are not lost
    on application restart.
*/

Item {
    id: settingsRoot

    /*!
        \qmlmethod void savePlaylist()
        Save episodes from PlaylistModel in local settings storage
    */
    function savePlaylist() {
        var playlistLength = _dataHolder.playlistModelData.count;
        playlistStorage.playlistSize = playlistLength;
        for(var i=0; i < playlistLength; ++i){
            var episodeItem = _dataHolder.playlistModelData.get(i);
            playlistStorage.setValue(i, JSON.stringify(episodeItem));
        }
    }

    /*!
        \qmlmethod void loadSavedPlaylist()
        Loads episodes from local settings storage into PlaylistModel
    */
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

    /*!
        \qmlmethod void clearPreviousSavedPlaylist()
        Clear previous stored episodes from local settings storage
    */
    function clearPreviousSavedPlaylist() {
        for(var c=0; c < playlistStorage.playlistSize; ++c) {
            var storedItem = playlistStorage.value(c, null);
            if(null === storedItem) {
                break;
            }

            playlistStorage.setValue(c, null)
        }
    }

    /*!
        \qmlmethod void clearPreviousSavedDownloads()
        Clear previous downloaded episodes from local settings storage
    */
    function clearPreviousSavedDownloads() {
        for(var c=0; c < downloadsStorage.downloadsSize; ++c) {
            var storedItem = downloadsStorage.value(c, null);
            if(null === storedItem) {
                break;
            }

            downloadsStorage.setValue(c, null)
        }
    }

    /*!
        \qmlmethod void saveDownloads()
        Save episodes from DownloadsModel in local settings storage
    */
    function saveDownloads() {
        var downloadsLength = _dataHolder.downloadsModelData.count;
        downloadsStorage.downloadsSize = downloadsLength;
        for(var i=0; i < downloadsLength; ++i){
            var episodeItem = _dataHolder.downloadsModelData.get(i);
            downloadsStorage.setValue(i, JSON.stringify(episodeItem));
        }
    }

    /*!
        \qmlmethod void loadDownloadedEpisodes()
        Loads episodes from local settings storage into DownloadsModel
    */
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
