import QtQuick 2.0
import Felgo 3.0
import ".."
import "../model"
import "../delegates"
import "../components"

VoycePage {
    id: rootPage
    title: qsTr("Downloads")
    searchBarEnabled: true
    showAcitivtyIndicator: false

    FilterProxyModel{
        id: filteredDownloadsModel
        targetModel: dataModel.downloadsModel
        targetRoleName: "title"
    }

    VoyceListView {
        id: downloadsListView
        model: filteredDownloadsModel
        loadingText: qsTr("Loading Downloads")

        delegate: EpisodeDelegate {
            id: localEpisodeDelegate

            isOfflineEpisode: true
            rightOption: Item { }

            leftOption: SwipeButton {
                text: qsTr("Remove")
                icon: IconType.plussquare
                height: parent.height
                backgroundColor: "red"

                onClicked: {
                    localEpisodeDelegate.rowDelegate.itemChanged()
                    localEpisodeDelegate.hideOptions()

                    var episodeIndex = filteredDownloadsModel.mapToSource(index)
                    broadcast.removeFromDownloads(episodeIndex, model.url)
                }
            }

        }
    }
}
