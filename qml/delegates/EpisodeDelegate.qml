import QtQuick 2.0
import Felgo 3.0

SwipeOptionsContainer {
    id: container

    property alias rowDelegate: row
    property bool isOfflineEpisode: false

    //Returns model data from current Delegate
    function getEpisodeData() {
        return {
            url: model.url,
            title: model.title,
            pubDate: model.pubDate,
            length: model.length
        }
    }

    SimpleRow {
        id: row
        text: model.title
        detailText: model.pubDate
        textItem.width: parent.width - playButton.width - 30

        IconButton {
            id: playButton
            size: app.dp(30)
            anchors.right: parent.right
            anchors.rightMargin: app.dp(6)
            anchors.verticalCenter: parent.verticalCenter
            icon: IconType.playcircle

            onClicked: {
                if(Theme.isAndroid && isOfflineEpisode) {
                    if(VoyceFileUtils.requestAndroidPermissions()) {
                        broadcast.playEpisode(getEpisodeData())
                    }
                    else {
                        nativeUtils.displayMessageBox(qsTr("Permissions not granted!"));
                        return;
                    }
                }

                broadcast.playEpisode(getEpisodeData())
            }
        }
    }

    leftOption: SwipeButton {
        text: qsTr("Add to Playlist")
        icon: IconType.plussquare
        height: row.height
        onClicked: {
            row.itemChanged()
            container.hideOptions()
            broadcast.addToPlaylist(getEpisodeData())
        }
    }

    rightOption: SwipeButton {
        height: row.height
        width: height

        text: qsTr("Download")
        icon: IconType.download
        onClicked: {
            row.itemChanged()
            container.hideOptions()
            broadcast.downloadEpisode(getEpisodeData())
        }
    }
}

