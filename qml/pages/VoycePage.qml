import QtQuick 2.0
import Felgo 3.0
import "../components"

/*!
    \qmltype VoycePage
    \inherits Page
    \brief VoycePage - basic page reused across the Voyce app.

    VoycePage is a simple updated version of the Felgo's \b{Page} component.
    It is used as a reusable page for multiple specific instances across the app.
*/

Page {

    /*!
        \qmlproperty bool searchBarEnabled
        If set, search bar will be displayed for targetted AppListView in the current page
    */
    property bool searchBarEnabled


    /*!
        \qmlproperty bool showAcitivtyIndicator
        If set, spinning activity indicator will be visible on top navigation bar
    */
    property bool showAcitivtyIndicator

    /*!
        \qmlproperty VoyceRightBarItem rightBarItem
        Updated version of \b{Page::rightBarItem}
    */
    rightBarItem: VoyceRightBarItem {
        activityIndicatorVisible: showAcitivtyIndicator
    }
}
