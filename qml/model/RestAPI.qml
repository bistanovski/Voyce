import QtQuick 2.0
import Felgo 3.0

Item {

    property int maxRequestTimeout: 10000 // use max request timeout of 10 sec
    readonly property bool busy: HttpNetworkActivityIndicator.enabled

    Component.onCompleted: {
        HttpNetworkActivityIndicator.setActivationDelay(0)
    }

    // private
    QtObject {
        id: _api_requestor
        property string podcastsUrl: "https://gpodder.net/api/2"

        function fetch(url, success, error) {
            HttpRequest.get(url)
            .timeout(maxRequestTimeout)
            .then(function(res) { success(res.body) })
            .catch(function(err) { error(err) });
        }
    }

    function getPodcastTags(numOfTags, success, error) {
        if(numOfTags > 0) {
            var url = _api_requestor.podcastsUrl + "/tags/" + numOfTags.toString() + ".json";
            _api_requestor.fetch(url, success, error)
        }
        else {
            error('Number of fetching tags must be greater than 0!')
        }
    }

    function getPodcastsForTag(tag, numOfPodcasts, success, error) {
        if('' !== tag) {
            var url = _api_requestor.podcastsUrl + "/tag/" + tag + "/" + numOfPodcasts.toString() + ".json";
            _api_requestor.fetch(url, success, error)
        }
        else {
            error('Searched tag must not be empty!')
        }
    }
}
