import QtQuick 2.0
import Felgo 3.0
import "."
import ".."
import "../model"
import "../delegates"

VoycePage {
    id: rootPage
    title: qsTr("Categories")
    showAcitivtyIndicator: dataModel.isBusy

    function fetchPodcastTags() {
        broadcast.fetchPodcastTags(100);
    }

    JsonListModel {
        id: podcastTagsModel
        source: dataModel.tags
        keyField: "tag"
        fields: ["tag", "title", "usage"]
    }

    FilterProxyModel{
        id: filteredCategoriesModel
        targetModel: podcastTagsModel
        targetRoleName: "title"
    }

    VoyceListView {
        id: categoriesListView
        model: filteredCategoriesModel
        loadingText: qsTr("Loading Categories")
        refreshFuncHandler: fetchPodcastTags
        delegate: CategoryDelegate {}
    }

    onAppeared: {
        fetchPodcastTags();
    }

    Component {
        id: podcastsPageComponent
        PodcastsPage { }
    }
}
