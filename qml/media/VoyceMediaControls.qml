import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

/*!
    \qmltype VoyceMediaControls
    \inherits ColumnLayout
    \brief VoyceMediaControls - simple container of Playback controls.

    VoyceMediaControls provides simple button controls for Play, Pause, Next,
    and Previous MediaPlayer actions.
*/

ColumnLayout {
    id: root

    spacing: dp(5)
    anchors.fill: parent

    /*!
        \qmlproperty bool enabledPlayPause
        Property which says whether Play/Pause button is enabled
    */
    property bool enabledPlayPause: false

    /*!
        \qmlproperty bool enabledPrevious
        Property which says whether Previous button is enabled
    */
    property bool enabledPrevious: false

    /*!
        \qmlproperty bool enabledNext
        Property which says whether Next button is enabled
    */
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
                color: "#F2D9B9"
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
