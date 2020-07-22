import Felgo 3.0
import QtQuick 2.0
import "model"
import "logic"
import "pages"

App {
    // app initialization
    Component.onCompleted: {
        // if device has network connection, clear cache at startup
        // you'll probably implement a more intelligent cache cleanup for your app
        // e.g. to only clear the items that aren't required regularly
        if(isOnline) {
            logic.clearCache()
        }
    }

    // business logic
    Logic {
        id: logic
    }

    // model
    DataModel {
        id: dataModel
        dispatcher: logic // data model handles actions sent by logic
    }

    // view
    Navigation {
        id: navigation

        // first tab
        NavigationItem {
            title: qsTr("Playlist")
            icon: IconType.list

            NavigationStack {
                splitView: tablet // use side-by-side view on tablets
                initialPage: PlaylistPage { }
            }
        }

        // second tab
        NavigationItem {
            title: qsTr("Explore")
            icon: IconType.cloud

            NavigationStack {
                splitView: tablet
                initialPage: ExplorePage { }
            }
        }

        // third tab
        NavigationItem {
            title: qsTr("Player")
            icon: IconType.playcircle

            NavigationStack {
                splitView: tablet
                initialPage: MediaPlayerPage { }
            }
        }

        // fourth tab
        NavigationItem {
            title: qsTr("Downloads")
            icon: IconType.download

            NavigationStack {
                splitView: tablet
                initialPage: DownloadsPage { }
            }
        }

        // fifth tab
        NavigationItem {
            title: qsTr("Settings")
            icon: IconType.adjust

            NavigationStack {
                splitView: tablet
                initialPage: SettingsPage { }
            }
        }
    }
}
