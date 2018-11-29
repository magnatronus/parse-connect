/// The main parse API
import 'object.dart';
import 'user.dart';
import 'funcs.dart';

/// This is the main Parse API class
/// It requires 3 values passed in the constructor
/// [endpoint] = This is the Parse Server API endpoint
/// [appID] = this identifies the application you are accessing
/// [clientKey] - this is your platform (REST) Client Key
class ParseAPI {
  final String endpoint;
  bool _debug = false;
  Map<String, String> _headers;

  /// Create the API object and set up the required headers
  ParseAPI(this.endpoint, appID, clientKey) {
    _headers = {
      "X-Parse-Application-Id": appID,
      "X-Parse-REST-API-Key": clientKey,
    };
  }

  /// Allow the debug messages to be turned on and off
  /// set [flag] to true to show the Parse-Connect debug help messages
  set debug(bool flag) {
    _debug = flag;
  }

  /// Interface to the Parse User Objects
  /// [userID] is an optional user objectId
  user([String userID]) {
    return User(endpoint, _headers, _debug, userID);
  }

  /// Interface to the Parse Custom Object
  /// [name] is the object classname to use
  object(name) {
    return Object(name, endpoint, _headers, _debug);
  }

  /// Interface to allow the running of cloud function
  /// [name] is the name of the cloud function to run
  function(name) {
    return ParseFunction(name, endpoint, _headers, _debug);
  }
}
