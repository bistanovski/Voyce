import QtQuick 2.0
import Felgo 3.0

Connections {
    id: rootConnections

    onClearTags: {
        _dataHolder.tags = []
    }

    onClearPodcasts: {
        _dataHolder.podcasts = []
    }

    onFetchPodcastTags: {
        function onSuccess(data) {
            _dataHolder.tags = data;
        }
        function onError(error) {
            console.log('Fetching PodcastTags failed:', error)
        }

        api.getPodcastTags(numOfTags, onSuccess, onError);
    }

    onFetchPodcastsForTag: {
        function onSuccess(data) {
            _dataHolder.podcasts = data;
        }
        function onError(error) {
            console.log('Fetching Podcasts failed:', error);
        }

        api.getPodcastsForTag(tag, numOfPodcasts, onSuccess, onError);
    }

    onAddToPlaylist: {
        _dataHolder.playlistUpdated = true;
        _dataHolder.playlistModelData.insert(0, episodeData);
    }

    onRemoveFromPlaylist: {
        _dataHolder.playlistUpdated = true;
        _dataHolder.playlistModelData.remove(episodeIndex, 1);
    }

    onClearAndSaveSettings: {
        var writeGranted = true;
        if(Theme.isAndroid) {
            writeGranted = VoyceFileUtils.requestAndroidPermissions();
            if(!writeGranted) {
                nativeUtils.displayMessageBox(qsTr("Permissions not granted!"));
            }
        }

        if(writeGranted && _dataHolder.playlistUpdated) {
            voyceSettings.clearPreviousSavedPlaylist();
            voyceSettings.savePlaylist();
        }

        if(writeGranted && _dataHolder.downloadsUpdated) {
            voyceSettings.clearPreviousSavedDownloads();
            voyceSettings.saveDownloads();
        }
    }

    onDownloadEpisode: {
        var writeGranted = true;

        if(Theme.isAndroid) {
            writeGranted = VoyceFileUtils.requestAndroidPermissions();
            if(!writeGranted) {
                nativeUtils.displayMessageBox(qsTr("Permissions not granted!"));
            }
        }

        if(writeGranted) {
            episodeDownloader.downloadEpisode(episodeData);
        }
    }

    onDownloadFinished: {
        _dataHolder.downloadsUpdated = true;
        _dataHolder.downloadsModelData.insert(0, episodeData);
    }

    onRemoveFromDownloads: {
        var deleteGranted = true;
        if(Theme.isAndroid) {
            deleteGranted = VoyceFileUtils.requestAndroidPermissions();
            if(!deleteGranted) {
                nativeUtils.displayMessageBox(qsTr("Permissions not granted!"));
            }
        }

        if(deleteGranted && VoyceFileUtils.deleteFile(localUrl)) {
            console.log('Episode Deleted!')
            _dataHolder.downloadsUpdated = true;
            _dataHolder.downloadsModelData.remove(episodeIndex, 1);
        }
    }
}
