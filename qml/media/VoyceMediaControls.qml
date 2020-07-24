import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

ColumnLayout {
    id: root

    spacing: dp(5)
    anchors.fill: parent

    property bool enabledPlayPause: false
    property bool enabledPrevious: false
    property bool enabledNext: false

    RowLayout {
        ProgressBar {
            Layout.fillWidth: true
            value: mediaPlayer.position / mediaPlayer.duration
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            AppText {
                anchors.centerIn: parent
                elide: Text.ElideRight
                text: rootControl.episodeTitle
                font.pixelSize: app.sp(12)
            }
        }
    }

    RowLayout {
        spacing: dp(50)
        Layout.alignment: Qt.AlignHCenter

        IconButton {
            id: previousButton
            icon: IconType.stepbackward
            size: app.dp(30)
            enabled: root.enabledPrevious

            onClicked: {
                mediaPlayer.playlist.previous();
            }
        }

        IconButton {
            id: playPauseButton
            icon: mediaPlayer.playbackState === MediaPlayer.PlayingState ? IconType.pause : IconType.playcircle
            size: app.dp(50)
            enabled: root.enabledPlayPause

            onClicked: {
                if(mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                    mediaPlayer.pause()
                }
                else {
                    mediaPlayer.play()
                }
            }
        }

        IconButton {
            id: nextButton
            icon: IconType.stepforward
            size: app.dp(30)
            enabled: root.enabledNext

            onClicked: {
                mediaPlayer.playlist.next();
            }
        }
    }

    //This item acts as a vertical spacer, which push the other elements to the top of the layout
    Item {
        Layout.fillHeight: true
    }
}
