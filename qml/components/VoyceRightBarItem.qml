import QtQuick 2.0
import Felgo 3.0

NavigationBarRow {

    property bool activityIndicatorVisible

    showMoreButton: false

    ActivityIndicatorBarItem {
        id: activityBarItem
        visible: activityIndicatorVisible
        animating: visible
        showItem: showItemIfRoom
    }

    IconButtonBarItem {
        id: searchButton
        icon: IconType.search
        showItem: showItemAlways
        onClicked: {
            searchBarEnabled = !searchBarEnabled
        }
    }
}
