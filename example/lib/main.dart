import 'package:flutter/material.dart';
import 'package:parse_connect/parse_connect.dart' as ParseConnect;

void main() => runApp(ParseDemo());

class ParseDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ParseDemo', home: DemoScreen());
  }
}

/// Simple Demo of using Parse_Connect to connect  a Flutter app to a Parse Server
/// This demo and the Package where developed and tested again  a server on the
/// https://www.back4app.com/  service and has not be tested again other Parser services
///
class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  ParseConnect.ParseAPI api = ParseConnect.ParseAPI(
      "https://parseapi.back4app.com",
      "{put_your_app_id_here}",
      "{put_your-REST-api_key_here}");

  @override
  initState() {
    super.initState();
    api.debug = true; // for testing lets print out some debug messages
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Back4App Parse Demo"),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              // Test Object Interface
              //_testObjectInterface("MyTestObject");

              // Test User interface
              _testUserInterface("fred", "password", "a@bad.not.email");
            },
            child: Text("Run Parse Test"),
          ),
        ],
      ),
    );
  }

  // This is an example of the User interface
  // This will run Create, Query, Login, Read, Update,
  _testUserInterface(String username, String password, String email) async {
    ParseConnect.ParseResult result;
    String userID, sessionToken;

    // CREATE a user object
    result = await api
        .user()
        .create({"username": username, "password": password, "email": email});
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    }

    // Verify the user with the returned session token
    sessionToken = result.data['sessionToken'];
    result = await api.user().validate(sessionToken);
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    //  Log user out
    result = await api.user().logout(sessionToken);
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    // RE-Verify the user with the returned session token
    sessionToken = result.data['sessionToken'];
    result = await api.user().validate(sessionToken);
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    /*
    // Query to see if an account exists already
    result = await api.user().query(where: '{"email": "$email"}');
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    // Send an Email Verification Request
    result = await api.user().verifyEmail(email);
    if(!result.ok){
     throw("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    // LOGIN user
    result = await api.user().login(username, password);
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }

    // note the session token & userid
    sessionToken = result.data['sessionToken'];
    userID = result.data['objectId'];

    // get user details
    print("Test READ()");
    result = await api.user(userID).read();
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    // Test Password Reset Request
    result = await api.user().passwordReset(email);
    if(!result.ok){
     throw("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    // Test UPDATE user
    result = await api
        .user(userID)
        .update({"jobtitle": " Developer Advocate"}, sessionToken);
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    /// DELETE the test user object
    result = await api.user(userID).delete(sessionToken);
    if(!result.ok){
     throw("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);
    */
  }

  /// This is an example of the calls that can be made again a custom Parse object
  // The methods will be run in the order of Create, Query, Update, Read, Delete
  _testObjectInterface(String objectClassName) async {
    ParseConnect.ParseResult result;
    String objectID;

    // CREATE a test object
    result =
        await api.object(objectClassName).create({"Name": "Around the Lake"});
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);
    objectID = result.data['objectId'];

    // QUERY ALL OBJECTS
    result = await api.object(objectClassName).query();
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    // UPDATE created object
    result = await api
        .object(objectClassName)
        .update(objectID, {"vehicle": "Motorbike"});

    // READ updated object
    result = await api.object(objectClassName).read(objectID);
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    // DELETE the created objet
    result = await api.object(objectClassName).delete(objectID);
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);
  }
}
