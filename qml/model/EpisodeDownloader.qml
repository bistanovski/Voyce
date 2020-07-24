import QtQuick 2.0
import Felgo 3.0

/*!
    \qmltype EpisodeDownloader
    \inherits DownloadableResource
    \brief EpisodeDownloader - basic MP3 downloader.
*/

DownloadableResource {
    storageLocation: FileUtils.DownloadLocation
    extractAsPackage: false

    /*!
        \qmlproperty var trackedEpisode
        Holds episode properties used for downloading
    */
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
