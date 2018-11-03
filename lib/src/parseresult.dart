/// A Simple object representing the result of a Parse API Call
class ParseResult {
  bool ok;
  Map data;
  int errorCode;
  String errorMessage;

  ParseResult(this.ok, this.data) {
    if (!ok) {
      errorCode = data['code'];
      errorMessage = data['error'];
    }
  }
}
