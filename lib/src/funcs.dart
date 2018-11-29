import "dart:convert";
import 'baseobject.dart';
import "parseresult.dart";

/// This class represents a Parse Cloud function (https://docs.parseplatform.org/rest/guide/#cloud-code)
/// and has 1 method [execute]
class ParseFunction extends BaseObject {
  final String functionName;

  ParseFunction(this.functionName, endpoint, headers, debug)
      : super(endpoint, headers, debug);

  /// Execute the cloud function with parameters
  /// [parameters] is a Map of the parameters to pass the cloud function being called
  execute(Map parameters) async {
    var result =
        await parseSave("/functions/$functionName", jsonEncode(parameters));
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }
}
