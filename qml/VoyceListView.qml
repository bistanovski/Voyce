import QtQuick 2.0
import Felgo 3.0

/*!
    \qmltype VoyceListView
    \inherits AppListView
    \brief VoyceListView - basic ListView component reused across the Voyce app.

    VoyceListView is a simple updated version of the Felgo's \b{AppListView} component.
*/

AppListView {
    id: listView
    anchors.fill: parent
    showSearch: searchBarEnabled
    emptyText.text: showAcitivtyIndicator ? loadingText : "No items available"

    /*!
        \qmlproperty string loadingText
        If set, while data is loaded, this text will be shown as main content
    */
    property string loadingText

    /*!
        \qmlproperty var refreshFuncHandler
        Callback function handler, which is used as target to invoke on
        PullToRefreshHandler::refresh() signal
    */
    property var refreshFuncHandler

    PullToRefreshHandler {
        refreshing: showAcitivtyIndicator
        pullToRefreshEnabled: !!refreshFuncHandler //Enabled if refreshFuncHandler is not null
        onRefresh: refreshFuncHandler()
    }

    onSearch: {
        model.searchValue = term
    }

    add: Transition {
        NumberAnimation {
            property: "opacity";
            from: 0;
            to: 1;
            duration: 200
            easing.type: Easing.OutQuad;
        }
    }

    addDisplaced: Transition {
        NumberAnimation {
            properties: "x,y";
            duration: 200
            easing.type: Easing.OutQuad;
        }
    }

    remove: Transition {
        NumberAnimation {
            property: "opacity";
            from: 1;
            to: 0;
            duration: 200
            easing.type: Easing.OutQuad;
        }
    }

    removeDisplaced: Transition {
        NumberAnimation {
            properties: "x,y";
            duration: 200
            easing.type: Easing.OutQuad;
        }
    }
}
