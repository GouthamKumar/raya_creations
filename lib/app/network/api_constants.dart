const sandboxEnv = 'https://api.rayacreations.com/';
const prodEnv = 'https://api.rayacreations.com/';

const isProdEnv = false;

const authorization = 'Authorization';
const accept = 'Accept';
const apiAccessKey = 'api-access-key';
const apiAccessKeyValue = 'A31AB78E-C4C7-4C9E-AD98-6D6A1B801E45';

const pathAlbums = 'Album/list';
const pathPodcasts = 'Poadcast/list?albumId=';
const pathBannersList = 'Banner/list?type=';

const connectionTimeout = 60000;
const receiveTimeout = 60000;
const noDataReceivedMessage = 'Response successful but no data received';

//error & success messages
const String strSuccess = 'success';
const errorSomethingWrong = 'An error occurred while processing the request';
const errorCancel = 'Request to API server was cancelled';
const errorConnectionTimeout = 'Connection timeout with API server';
const errorNetworkConnection =
    'Connection to API server failed due to internet connection';
const errorReceiveTimeout = 'Receive timeout in connection with API server';
const errorBadResponse = 'Received invalid status code:';
const errorSendTimeout = 'Send timeout in connection with API server';
const errorBadCertificate = 'Bad certificate received from API server';
const errorConnection = 'Connection error with API server';
const errorAuthFailed = 'App authorization failed';
const errorFailToLoad = 'Failed to load data';
const errorBadRequest = 'Bad Request';
const errorUnauthorized = 'Unauthorized';
const errorForbidden = 'Forbidden';
const errorNotFound = 'Not Found';
const errorCache = 'Cache Error';
const errorConflict = 'Conflict Error';
const errorInternal = 'Internal Server Error';
const errorNoContent = 'No Content';
const errorDefault = 'Received unexpected status code:';

enum RequestType {
  getPodcastAlbums,
  getPodCasts,
  getBanners,
  getError,
}

enum RequestMethod {
  get,
  post,
  put,
  getError,
}
