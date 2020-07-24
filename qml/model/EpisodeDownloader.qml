import QtQuick 2.0
import Felgo 3.0

DownloadableResource {
    storageLocation: FileUtils.DownloadLocation
    extractAsPackage: false

    property var trackedEpisode

    onStatusChanged: {
        if(DownloadableResource.Available === status) {
            nativeUtils.displayMessageBox(qsTr("Download Complete!"));
            trackedEpisode.url = storagePath;
            broadcast.downloadFinished(trackedEpisode);
        }
    }

    function downloadEpisode(episodeData) {
        trackedEpisode = episodeData
        storageName = trackedEpisode.title + ".mp3";
        source = trackedEpisode.url;
        if(status === DownloadableResource.UnAvailable) {
            download();
        }
    }
}
