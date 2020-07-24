import QtQuick 2.0
import Felgo 3.0
import "../settings"

/*!
    \qmltype DataModel
    \inherits Item
    \brief DataModel - main data holder and processor.

    DataModel is the main component which integrates RestApi, VoyceSettings,
    EpisodeDownloader and DataModelConnections objects. Also contain additional
    Item instance for holding the data in separate models as arrays and
    JsonListModel instances.
*/

Item {
    id: root

    /*!
        \qmlproperty alias dispatcher
        Alias property for connecting outside signal dispatcher
    */
    property alias dispatcher: dataConnection.target

    /*!
        \qmlproperty bool isBusy
        Holds status whether RestApi is busy
    */
    readonly property bool isBusy: api.busy

    /*!
        \qmlproperty alias tags
        Alias property for Tags model
    */
    readonly property alias tags: _dataHolder.tags

    /*!
        \qmlproperty alias podcasts
        Alias property for Podcasts model
    */
    readonly property alias podcasts: _dataHolder.podcasts

    /*!
        \qmlproperty alias playlistModel
        Alias property for Playlist model
    */
    readonly property alias playlistModel: _dataHolder.playlistModelData

    /*!
        \qmlproperty alias downloadsModel
        Alias property for Downloads model
    */
    readonly property alias downloadsModel: _dataHolder.downloadsModelData

    /*!
        \qmlproperty alias mainSettings
        Alias property for VoyceSettings instance
    */
    property alias mainSettings: voyceSettings

    VoyceSettings {
        id: voyceSettings
    }

    RestAPI {
        id: api
    }

    Item {
        id: _dataHolder
        property var tags: []
        property var podcasts: []

        property alias playlistModelData: playlistModel
        property bool playlistUpdated: false

        property alias downloadsModelData: downloadsModel
        property bool downloadsUpdated: false

        readonly property string keyFieldValue: "url"
        readonly property var fieldValues: ["url", "title", "pubDate", "length"]

        JsonListModel {
            id: playlistModel
            keyField: _dataHolder.keyFieldValue
            fields: _dataHolder.fieldValues
        }

        JsonListModel {
            id: downloadsModel
            keyField: _dataHolder.keyFieldValue
            fields: _dataHolder.fieldValues
        }
    }

    EpisodeDownloader {
        id: episodeDownloader
    }

    DataModelConnections {
        id: dataConnection
    }
}
