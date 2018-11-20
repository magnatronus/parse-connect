# parse_connect package for Flutter

Parse_Connect is a package that provides Parse client functionality for Flutter. It is currently based on , and developed against,  a Parse server setup on [Back4App](http://www.back4app.com). This first release is limited and provides basic functionality for:

- *Object*
- *User*

With it you should be able to create, edit, update and delete Objects as well as signing up, updating, deleting and logging on Users.


## release 0.0.6
This update fixes an issue that manifested itself when logging different users in and out on the same device. As the *headers* Map was final each call added to the header params which meant when logging in, then out, then in as a different user the old sessionToken remained and caused an *Invalid SessionToken* error.

Each base call now uses a master copy of the *headers* map so only the basic *headers* and the additional ones required for the specific call are passed.



## release 0.0.5
This now has 2 additional methods added to the **User** object

- *validate(sessionToken)*
- *logout(sessionToken)*



This is currently **Work in Progress**.


## Example Usage
As I **eat my own dog food** (never did like that phrase, but it kinda fits) I will put some code snippets on the [project Wiki here](https://github.com/magnatronus/parse-connect/wiki).



## Getting Started

For package install [see here](https://pub.dartlang.org/packages/parse-connect).

For help getting started with Flutter, view the online [documentation](https://flutter.io/).
