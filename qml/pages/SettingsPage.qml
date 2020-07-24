import QtQuick 2.0
import Felgo 3.0

Page {
    id: rootPage
    title: qsTr("Settings")

    AppText {
        id: textItem
        anchors.centerIn: parent
        text: qsTr("Save Playlist and Downloads settings!")
        font.pixelSize: app.sp(12)
    }

    AppButton {
        icon: IconType.save
        iconSize: app.dp(36)
        visible: true // show on all platforms, default is only Android

        anchors.top: textItem.bottom
        anchors.horizontalCenter: textItem.horizontalCenter

        onClicked: {
            broadcast.clearAndSaveSettings();
        }
    }
}
