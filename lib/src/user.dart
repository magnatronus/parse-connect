import "dart:convert";
import 'baseobject.dart';
import "parseresult.dart";

/// This class represents a Parse User
/// and has the following methods:
/// [create]
/// [read]
/// [query]
/// [login]
/// [logout]
/// [validate]
/// [passwordReset]
/// [verifyEmail]
/// [update]
/// [delete]
///
/// ref https://docs.parseplatform.org/rest/guide/#users
class User extends BaseObject {
  String userID;

  User(endpoint, headers, debug, this.userID) : super(endpoint, headers, debug);

  /// Create a new User account
  /// [object] - is the user account detail to create. This should have at least "username" &  "password"
  /// ref https://docs.parseplatform.org/rest/guide/#signing-up
  create(Map object) async {
    Map<String, String> params = {"X-Parse-Revocable-Session": "1"};
    var result = await parseSave("/Users", jsonEncode(object), params);
    return ParseResult((result.statusCode == 201), jsonDecode(result.body));
  }

  /// Get the details of a known user by their unique id
  /// ref https://docs.parseplatform.org/rest/guide/#retrieving-users
  read() async {
    var result = await parseQuery("/Users/$userID");
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Generate a User query to get a list of matching users
  /// ref https://docs.parseplatform.org/rest/guide/#queries
  query({where, order, limit, skip, keys, include}) async {
    String query = "/Users";
    Map paramMap = Map();
    if (where != null) paramMap['where'] = where;
    if (order != null) paramMap["order"] = order;
    if (limit != null) paramMap["limit"] = limit;
    if (skip != null) paramMap["skip"] = skip;
    if (keys != null) paramMap["keys"] = keys;
    if (include != null) paramMap["include"] = include;
    String params = buildParamsFromMap(paramMap);
    var result = await parseQuery((params != null) ? "$query$params" : query);
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Login an existing user with a username and password
  /// [un] - the username of the account being logged in to
  /// [pwd] - the associated account password
  /// ref https://docs.parseplatform.org/rest/guide/#logging-in
  login(String un, String pwd) async {
    String params = buildParamsFromMap({"username": un, "password": pwd});
    var result = await parseLogin(params);
    if (result.statusCode == 200) {
      super.headers["X-Parse-Session-Token"] =
          jsonDecode(result.body)["sessionToken"];
    }
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Log the current user associated with [sessionToken] out of the current application
  /// ref https://docs.parseplatform.org/rest/guide/#deleting-sessions
  logout() async {
    var result = await parsePost("/logout");
    super.headers.remove("X-Parse-Session-Token");
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Validate the user by a session Token
  /// If the session is valid it will set the API session to the passed in value
  /// [sessionToken] - a session token returned in a user.create or user.login
  /// ref https://docs.parseplatform.org/rest/guide/#validating-session-tokens--retrieving-current-user
  validate(String sessionToken) async {
    Map<String, String> additionalHeader = {
      "X-Parse-Session-Token": sessionToken
    };
    var result = await parseQuery("/Users/me", additionalHeader);
    if (result.statusCode == 200) {
      super.headers["X-Parse-Session-Token"] = sessionToken;
    }
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// This will initiate a password reset for the selected email address
  /// [email] - The email address associated with the account for password reset
  /// ref https://docs.parseplatform.org/rest/guide/#requesting-a-password-reset
  passwordReset(String email) async {
    Map<String, String> body = {"email": email};
    var result = await parseSave("/requestPasswordReset", jsonEncode(body));
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Sends out another email verification mail (but only if account NOT verified)
  /// [email] - the email address to verify
  /// ref https://docs.parseplatform.org/rest/guide/#verifying-emails
  verifyEmail(String email) async {
    Map<String, String> body = {"email": email};
    var result = await parseSave("/verificationEmailRequest", jsonEncode(body));
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Update a users details
  /// [data] is a map of the user data to update
  /// ref https://docs.parseplatform.org/rest/guide/#updating-users
  update(Map data) async {
    var result = await parseUpdate("/Users", userID, jsonEncode(data));
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Delete an EXISTING User
  /// [id] - the id of the user to delete
  /// ref https://docs.parseplatform.org/rest/guide/#deleting-users
  delete() async {
    var result = await parseDelete("/Users", userID);
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }
}
