import QtQuick 2.0
import Felgo 3.0
import ".."
import "../model"
import "../delegates"

VoycePage {
    id: rootPage
    title: qsTr("Podcasts: ") + category
    showAcitivtyIndicator: dataModel.isBusy

    property string tag
    property string category

    onTagChanged: {
        if('' !== tag) {
            fetchPodcastsForTag()
        }
        else {
            console.log('error: Searched tag must not be empty!')
        }
    }

    function fetchPodcastsForTag() {
        broadcast.clearPodcasts()
        broadcast.fetchPodcastsForTag(tag, 40)
    }

    JsonListModel {
        id: podcastsModel
        source: dataModel.podcasts
        keyField: "url"
        fields: ["url", "title", "author", "description", "scaled_logo_url", "website"]
    }

    FilterProxyModel{
        id: filteredPodcastsModel
        targetModel: podcastsModel
        targetRoleName: "title"
    }

    VoyceListView {
        id: podcastsListView
        model: filteredPodcastsModel
        loadingText: qsTr("Loading Podcasts")
        refreshFuncHandler: fetchPodcastsForTag
        delegate: PodcastDelegate{}
    }

    Component {
        id: episodesPageComponent
        EpisodesPage { }
    }
}
