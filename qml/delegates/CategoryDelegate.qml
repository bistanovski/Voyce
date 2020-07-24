import QtQuick 2.0
import Felgo 3.0

SimpleRow {
    text: model.title
    detailText: qsTr("Usage: ") + model.usage

    onSelected: {
        var pageOptions = {
            category: model.title,
            tag: model.tag
        }

        rootPage.navigationStack.popAllExceptFirstAndPush(podcastsPageComponent, pageOptions)
    }
}
