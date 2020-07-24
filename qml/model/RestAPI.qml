import QtQuick 2.0
import Felgo 3.0

/*!
    \qmltype RestAPI
    \inherits Item
    \brief RestAPI - basic Http client.

    RestAPI is a simple Http client which is used to retrieve data from the Internet.
    In it's core uses \b{HttpRequest} element which is asynchronus client implementation.
*/

Item {

    /*!
        \qmlproperty int maxRequestTimeout
        Maximum request timeout. Default 10 seconds
    */
    property int maxRequestTimeout: 10000

    /*!
        \qmlproperty int bool busy
        Holds confirmation whether HttpClient is processing request
    */
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


    /*!
        \qmlmethod void getPodcastTags(numOfTags, success, error)

        Invoke new fetching of Podcast Tags (Categories)
        \a numOfTags  - number of results
        \a success - function callback for successful processing of the result
        \a error - function callback for failed processing of the result
    */
    function getPodcastTags(numOfTags, success, error) {
        if(numOfTags > 0) {
            var url = _api_requestor.podcastsUrl + "/tags/" + numOfTags.toString() + ".json";
            _api_requestor.fetch(url, success, error)
        }
        else {
            error('Number of fetching tags must be greater than 0!')
        }
    }

    /*!
        \qmlmethod void ggetPodcastsForTag(tag, numOfPodcasts, success, error)
        Invoke new fetching of Podcasts for selected \a tag (Category)
        \a numOfPodcasts - number of results
        \a success - function callback for successful processing of the result
        \a error - function callback for failed processing of the result
    */
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
