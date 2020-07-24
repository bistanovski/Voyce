import QtQuick 2.0
import Felgo 3.0
import QtQuick.XmlListModel 2.12
import ".."
import "../model"
import "../delegates"
import "../components"

VoycePage {
    id: rootPage
    title: qsTr("Episodes: ") + podcastTitle
    showAcitivtyIndicator: episodesModel.status === XmlListModel.Loading

    property string podcastTitle
    property string podcastUrl

    onPodcastUrlChanged: {
        if('' !== podcastUrl) {
            fetchEpisodes()
        }
    }

    function fetchEpisodes() {
        episodesModel.source = podcastUrl
    }

    XmlListModel {
        id: episodesModel
        source: rootPage.podcastUrl
        query: "/rss/channel/item"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "pubDate"; query: "pubDate/string()" }
        XmlRole { name: "url"; query: "enclosure/@url/string()" }
        XmlRole { name: "length"; query: "enclosure/@type/string()" }
    }

    FilterProxyModel{
        id: filteredEpisodesModel
        targetModel: episodesModel
        targetRoleName: "title"
    }

    VoyceListView {
        id: episodesListView
        model: filteredEpisodesModel
        loadingText: qsTr("Loading Episodes")
        delegate: EpisodeDelegate {}
    }
}
