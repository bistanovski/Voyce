import QtQuick 2.0

Item {
    // actions
    signal clearCache()

    signal clearTags()
    signal fetchPodcastTags(var numOfTags)

    signal clearPodcasts()
    signal fetchPodcastsForTag(var tag, var numOfPodcasts)

    signal playEpisode(var episodeData)

    signal downloadEpisode(var episodeData)
    signal downloadFinished(var episodeData)
    signal removeFromDownloads(var episodeIndex, var localUrl)

    signal addToPlaylist(var episodeData)
    signal removeFromPlaylist(var episodeIndex)

    signal clearAndSaveSettings()
}
