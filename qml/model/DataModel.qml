import QtQuick 2.0
import Felgo 3.0
import "../settings"

Item {
    id: root

    property alias dispatcher: dataConnection.target
    readonly property bool isBusy: api.busy

    readonly property alias tags: _dataHolder.tags
    readonly property alias podcasts: _dataHolder.podcasts
    readonly property alias playlistModel: _dataHolder.playlistModelData
    readonly property alias downloadsModel: _dataHolder.downloadsModelData

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
