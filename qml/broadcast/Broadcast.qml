import QtQuick 2.0

/*!
    \qmltype Broadcast
    \inherits Item
    \brief Broadcast - basic signal dispatcher.

    Broadcast element is built as signal dispatcher, which are used between different
    elements and objects in Voyce application. Each item/object instance can "subscribe"
    to the signals provided in Broadcast, and on new emit, they can handle the processing
    part in their part of code blocks. This is good initial approach for centralized registrar
    of events for simple applications.
*/

Item {
    /*!
        \qmlsignal clearCache()
        Emitted when network cache clearing is needed
    */
    signal clearCache()

    /*!
        \qmlsignal clearTags()
        Emitted when podcast tags stored data has to be cleared
        \note \b{tags}, refer on the same thing as \b{Category} in which podcasts are grouped
    */
    signal clearTags()

    /*!
        \qmlsignal fetchPodcastTags(var numOfTags)
        Emitted when new podcast tags need to be fetched, with \e{numOfTags} total tags
    */
    signal fetchPodcastTags(var numOfTags)

    /*!
        \qmlsignal clearPodcasts(var numOfTags)
        Emitted when new podcast data has to be cleared
    */
    signal clearPodcasts()

    /*!
        \qmlsignal fetchPodcastsForTag(var tag, var numOfPodcasts)
        Emitted when new search for podcasts based on \e{tag} and total \e{numOfPodcasts} results
    */
    signal fetchPodcastsForTag(var tag, var numOfPodcasts)

    /*!
        \qmlsignal playEpisode(var episodeData)
        Emitted when selected \e{episodeData} object is scheduled for playing
    */
    signal playEpisode(var episodeData)


    /*!
        \qmlsignal downloadEpisode(var episodeData)
        Emitted when selected \e{episodeData} object is scheduled for downloading
    */
    signal downloadEpisode(var episodeData)

    /*!
        \qmlsignal downloadFinished(var episodeData)
        Emitted when \e{episodeData} object has finished downloading
    */
    signal downloadFinished(var episodeData)

    /*!
        \qmlsignal removeFromDownloads(var episodeIndex, var localUrl)
        Emitted when episode with \e{episodeIndex} located on \e{localUrl} need to be deleted
    */
    signal removeFromDownloads(var episodeIndex, var localUrl)

    /*!
        \qmlsignal addToPlaylist(var episodeData)
        Emitted when \e{episodeData} object need to be added in the current playlist
    */
    signal addToPlaylist(var episodeData)

    /*!
        \qmlsignal removeFromPlaylist(var episodeIndex)
        Emitted when episode with \e{episodeIndex} need to be removed from the current playlist
    */
    signal removeFromPlaylist(var episodeIndex)

    /*!
        \qmlsignal clearAndSaveSettings()
        Emitted when settings need to be updated
    */
    signal clearAndSaveSettings()
}
