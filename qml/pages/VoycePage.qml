import QtQuick 2.0
import Felgo 3.0
import "../components"

Page {

    property bool searchBarEnabled
    property bool showAcitivtyIndicator

    rightBarItem: VoyceRightBarItem {
        activityIndicatorVisible: showAcitivtyIndicator
    }
}
