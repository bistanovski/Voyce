import QtQuick 2.0
import Felgo 3.0

SimpleRow {
    text: model.title
    detailText: qsTr("Author: ") + model.author

    imageSource: model.scaled_logo_url
    imageMaxSize: app.dp(96)

    onSelected: {
        var pageOptions = {
            podcastTitle: model.title,
            podcastUrl: model.url
        }

        rootPage.navigationStack.push(episodesPageComponent, pageOptions)
    }
}
