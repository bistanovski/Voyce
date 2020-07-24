import Felgo 3.0
import QtQuick 2.0
import "model"
import "broadcast"
import "pages"
import "media"

App {
    id: app

    onInitTheme: {
        Theme.colors.tintColor = "#E26155"
    }

    Component.onCompleted: {
        // if device has network connection, clear cache at startup
        // you'll probably implement a more intelligent cache cleanup for your app
        // e.g. to only clear the items that aren't required regularly

        HttpRequest.config({ cache: true });

        if(isOnline) {
            broadcast.clearCache()
        }
    }

    onClosing: {
        close.accepted = false;
        broadcast.clearAndSaveSettings();
        close.accepted = true;
    }

    Broadcast {
        id: broadcast
    }

    DataModel {
        id: dataModel
        dispatcher: broadcast
    }

    Navigation {
        id: navigation
        navigationMode: navigationModeDrawer
        height: parent.height - mediaPlayer.height

        NavigationItem {
            title: qsTr("Playlist")
            icon: IconType.list

            NavigationStack {
                initialPage: PlaylistPage { }
            }
        }

        NavigationItem {
            title: qsTr("Explore")
            icon: IconType.cloud

            NavigationStack {
                splitView: tablet
                initialPage: CategoriesPage { }
            }
        }

        NavigationItem {
            title: qsTr("Downloads")
            icon: IconType.download

            NavigationStack {
                initialPage: DownloadsPage { }
            }
        }

        NavigationItem {
            title: qsTr("Settings")
            icon: IconType.adjust

            NavigationStack {
                initialPage: SettingsPage { }
            }
        }
    }

    VoyceMediaPlayer {
        id: mediaPlayer
        dispatcher: broadcast

        height: dp(100)
        width: parent.width
        anchors.bottom: parent.bottom
    }
}
