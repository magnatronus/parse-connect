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
/// https://www.back4app.com/  service and has not be tested again other Parse services
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
              //_testUserInterface();

              // Test the cloud function interface
              _testCloudFunctionInterface();
            },
            child: Text("Run Parse Test"),
          ),
        ],
      ),
    );
  }

  // simple example of executing a cloud function
  _testCloudFunctionInterface() async {
    ParseConnect.ParseResult result;

    Map params = {"firstName": "Fred", "lastName": "Flintstone"};
    result = await api.function("test").execute(params);
    print(result.ok);
    print(result.data);
  }

  // This is an example of the User interface
  // This will run Create, Query, Login, Read, Update,
  _testUserInterface() async {
    ParseConnect.ParseResult result;
    String userId, sessionToken;

/*
    // CREATE a user object (user "FRED")
    print("CREATE USER: fred --------------------------------");
    result = await api
        .user()
        .create({"username": "fred", "password": "password"});
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    }

    // Verify the user with the returned session token
    print("VERIFY USER: fred --------------------------------");
    sessionToken = result.data['sessionToken'];
    result = await api.user().validate(sessionToken);
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    //  Log user out
    print("LOGOUT USER: fred --------------------------------");
    result = await api.user().logout();
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }



    // CREATE a user object (user "WILMA")
    print("CREATE USER: wilma --------------------------------");
    result = await api
        .user()
        .create({"username": "wilma", "password": "password"});
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    }

    // Verify the user with the returned session token
    print("VERIFY USER: wilma --------------------------------");
    sessionToken = result.data['sessionToken'];
    result = await api.user().validate(sessionToken);
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    //  Log user out
    print("LOGOUT USER: wilma --------------------------------");
    result = await api.user().logout();
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    // Log in Fred
    print("LOGIN USER: fred --------------------------------");
    result = await api.user().login("fred", "password");
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    userId = result.data['objectId'];

    // Add an object
    print("ADD OBJECT FOR: fred --------------------------------");    
    result = await api.object("BedRock").create({
      "Name": "This is Fred's Object",
      "ACL": {
		    userId: {
			    "read": true,
			    "write": true
		    }
	    }
    });
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    //  Log fred out
    print("LOGOUT USER: fred --------------------------------");
    result = await api.user().logout();
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    // Log in Wilma
    print("LOGIN USER: wilma --------------------------------");
    result = await api.user().login("wilma", "password");
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    userId = result.data['objectId'];
    // Add an object
    print("ADD OBJECT FOR: wilma --------------------------------");    
    result = await api.object("BedRock").create({
      "Name": "This is Wilma's Object",
      "ACL": {
		    userId: {
			    "read": true,
			    "write": true
		    }
	    }  
    });
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    //  Log wilma out
    print("LOGOUT USER: wilma --------------------------------");
    result = await api.user().logout();
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }


    // Log in Fred
    print("LOGIN USER: fred --------------------------------");
    result = await api.user().login("fred", "password");
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    userId = result.data['objectId'];

    // Query for ALL fred's object
    print("QUERY objects: fred --------------------------------");    
    result = await api.object("BedRock").query();
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    //  Log fred out
    print("LOGOUT USER: fred --------------------------------");
    result = await api.user().logout();
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

    // Log in Wilma
    print("LOGIN USER: fred --------------------------------");
    result = await api.user().login("wilma", "password");
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    userId = result.data['objectId'];

    // Query for ALL Wilma's object
    print("QUERY objects: wilma --------------------------------");    
    result = await api.object("BedRock").query();
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    //  Log wilma out
    print("LOGOUT USER: wilma --------------------------------");
    result = await api.user().logout();
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    } else {
      print(result.data);
    }

  */

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
   */

    // CREATE a user object
    result =
        await api.user().create({"username": "barney", "password": "password"});
    if (!result.ok) {
      print("${result.errorCode}:${result.errorMessage}");
    }

    // LOGIN user
    result = await api.user().login("barney", "password");
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    userId = result.data['objectId'];

    // get user details
    print("Test READ()");
    result = await api.user(userId).read();
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    // Test UPDATE user
    result = await api
        .user(userId)
        .update({"jobtitle": "Fred's sidekick and father to Pebbles"});
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    /// DELETE the test user object
    result = await api.user(userId).delete();
    if (!result.ok) {
      throw ("${result.errorCode}:${result.errorMessage}");
    }
    print(result.data);

    /*
    // Test Password Reset Request
    result = await api.user().passwordReset(email);
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
