import 'package:http/http.dart' as http;

/// The base Parse Object that does the communication with the Parse Back4App server
/// this is not used in its own right but serves as a base object for other Parse classes
class BaseObject {
  final String endpoint;
  final Map<String, String> headers;
  final bool debug;

  BaseObject(this.endpoint, this.headers, this.debug);

  /// Helper function to build our query string from the passed in [map] parameter
  buildParamsFromMap(Map map) {
    String result;
    map.forEach((key, value) {
      result = (result != null) ? result + "&$key=$value" : "?$key=$value";
    });
    return result;
  }

  /// Specific Login function so that we automatically track the user sessionToken in other calls
  parseLogin(String params) async {
    String url = "$endpoint/login/$params";
    Map<String, String> _headers = Map.fromEntries(headers.entries);
    _headers["X-Parse-Revocable-Session"] = "1";
    _debugPrint(" Pass Query URL call: $url");
    _debugPrint(headers);
    return http.get(Uri.encodeFull(url), headers: _headers);
  }

  /// POST: Similar to a ParseSave but there is NO body that needs to be associated with the POST
  /// [params] is optional and will add new header values to the Parse call
  parsePost(String query, [Map params]) async {
    String url = "$endpoint$query";
    Map<String, String> _headers = Map.fromEntries(headers.entries);
    if (params != null) {
      _headers.addAll(params);
    }
    _debugPrint(" Pass Save URL call: $url");
    _debugPrint(_headers);
    return http.post(Uri.encodeFull(url), headers: _headers);
  }

  /// CREATE: Run a query to create a new Parse object
  /// [params] is optional and will add new header values to the Parse call
  parseSave(String query, String data, [Map params]) async {
    String url = "$endpoint$query";
    Map<String, String> _headers = Map.fromEntries(headers.entries);
    if (params != null) {
      _headers.addAll(params);
    }
    _debugPrint(" Pass Save URL call: $url");
    _debugPrint(" Body Content: $data");
    _debugPrint(_headers);
    return http.post(Uri.encodeFull(url), headers: _headers, body: data);
  }

  /// READ: Run a Parse Query to find and return data
  parseQuery(String query, [Map params]) async {
    String url = "$endpoint$query";
    Map<String, String> _headers = Map.fromEntries(headers.entries);
    if (params != null) {
      _headers.addAll(params);
    }
    _debugPrint(" Pass Query URL call: $url");
    _debugPrint(_headers);
    return http.get(Uri.encodeFull(url), headers: _headers);
  }

  // UPDATE: Run a query to update an existing Parse object
  parseUpdate(String query, String id, String data, [Map params]) {
    String url = "$endpoint$query/$id";
    Map<String, String> _headers = Map.fromEntries(headers.entries);
    if (params != null) {
      _headers.addAll(params);
    }
    _debugPrint(" Pass Save URL call: $url");
    _debugPrint(_headers);
    return http.put(Uri.encodeFull(url), headers: _headers, body: data);
  }

  /// DELETE: Run a query to delete an existing Parse object
  parseDelete(String query, String id, [Map params]) {
    String url = "$endpoint$query/$id";
    Map<String, String> _headers = Map.fromEntries(headers.entries);
    if (params != null) {
      _headers.addAll(params);
    }
    _debugPrint(" Pass Save URL call: $url");
    _debugPrint(_headers);
    return http.delete(Uri.encodeFull(url), headers: _headers);
  }

  /// Used for printing debug messages when switched on
  _debugPrint(value) {
    if (debug) {
      print(value);
    }
  }
}
