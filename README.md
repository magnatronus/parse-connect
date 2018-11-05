# parse_connect package for Flutter

Parse_Connect is a package that provides Parse client functionality for Flutter. It is currently based on , and developed against,  a Parse server setup on [Back4App](http://www.back4app.com). This first release is limited and provides basic functionality for:

- *Object*
- *User*

With it you should be able to create, edit, update and delete Objects as well as signing up, updating, deleting and logging on Users.

This is currently **VERY MUCH** Work in Progress.


## Example Usage
As I **eat my own dog food** (never did like that phrase, but it kinda fits) I will put some code snippets here to show various scenarios - I may move this to the Wiki section later.

## GeoPoint Queries on Objects
I am storing info on Places with a GeoPoint column (called *Location*) and needed to query for nearby places, so this is how I did it:

```
// create our Where query as a map
Map where = {
    "Location": {
    "\$nearSphere": {
        "__type": "GeoPoint", "latitude": currentLocation.latitude, "longitude": currentLocation.longitude
    }
    }
};

// now query the server
//api.debug = true;
ParseConnect.ParseResult result = await api.object("Places").query(
    where: jsonEncode(where)
);
  
```



## Getting Started

For package install [see here](https://pub.dartlang.org/packages/parse-connect).

For help getting started with Flutter, view the online [documentation](https://flutter.io/).
