import QtQuick 2.0
import Felgo 3.0

Item {
    // property to configure target dispatcher / logic
    property alias dispatcher: logicConnection.target

    // whether api is busy (ongoing network requests)
    readonly property bool isBusy: api.busy

    Connections {
        id: logicConnection
    }

    // rest api for data access
    RestAPI {
        id: api
        maxRequestTimeout: 3000 // use max request timeout of 3 sec
    }

    // storage for caching
    Storage {
        id: cache
    }
}
