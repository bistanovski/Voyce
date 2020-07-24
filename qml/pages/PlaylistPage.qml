import QtQuick 2.0
import Felgo 3.0
import ".."
import "../model"
import "../delegates"
import "../components"

VoycePage {
    id: rootPage
    title: qsTr("Playlist")
    searchBarEnabled: true
    showAcitivtyIndicator: false

    FilterProxyModel{
        id: filteredPlaylistModel
        targetModel: dataModel.playlistModel
        targetRoleName: "title"
    }

    VoyceListView {
        id: playlistListView
        model: filteredPlaylistModel
        loadingText: qsTr("Loading Playlist")

        delegate: EpisodeDelegate {
            id: playlistDelegate

            rightOption: Item { }

            leftOption: SwipeButton {
                text: qsTr("Remove")
                icon: IconType.plussquare
                height: parent.height
                backgroundColor: "red"

                onClicked: {
                    playlistDelegate.rowDelegate.itemChanged()
                    playlistDelegate.hideOptions()

                    var episodeIndex = filteredPlaylistModel.mapToSource(index)
                    broadcast.removeFromPlaylist(episodeIndex)
                }
            }

        }
    }
}
