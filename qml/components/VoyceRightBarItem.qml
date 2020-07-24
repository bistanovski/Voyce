import QtQuick 2.0
import Felgo 3.0

/*!
    \qmltype VoyceRightBarItem
    \inherits NavigationBarRow
    \brief VoyceRightBarItem - basic update of NavigationBarRow.

    VoyceRightBarItem is a simple updated version of the Felgo's \b{NavigationBarRow} component.
    It sets \b{ActivityIndicatorBarItem} and \b{IconButtonBarItem} elements.
*/

NavigationBarRow {

    /*!
        \qmlproperty bool activityIndicatorVisible
        If set, activity indicator in the navigation bar will be visible.
    */
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
