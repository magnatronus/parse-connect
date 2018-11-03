import "dart:convert";
import 'baseobject.dart';
import "parseresult.dart";

/// This class represents a Parse Object (https://docs.parseplatform.org/rest/guide/#objects)
class Object extends BaseObject {
  final String className;

  Object(this.className, endpoint, headers, debug)
      : super(endpoint, headers, debug);

  /// Get the details of an object by its unique id
  /// [id] is the objectId of the object being looked for
  /// ref https://docs.parseplatform.org/rest/guide/#retrieving-objects
  read(String id) async {
    var result = await parseQuery("/classes/$className/$id");
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Generate a query object and send to Parse Server
  /// For info on the param and their values
  /// ref https://docs.parseplatform.org/rest/guide/#queries
  query({where, order, limit, skip, keys, include}) async {
    String query = "/classes/$className";
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

  /// Create a new Object and save to the Parse server
  /// [object] is a Map of the object to create
  /// ref https://docs.parseplatform.org/rest/guide/#creating-objects
  create(Map object) async {
    var result = await parseSave("/classes/$className", jsonEncode(object));
    return ParseResult((result.statusCode == 201), jsonDecode(result.body));
  }

  /// Update an EXISTING Parse Object
  /// [id] is the id of an existing object
  /// [object] is a map of the object information that needs updating
  /// ref https://docs.parseplatform.org/rest/guide/#updating-objects
  update(String id, Map object) async {
    var result =
        await parseUpdate("/classes/$className", id, jsonEncode(object));
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }

  /// Delete an EXISTING Parse Object
  /// [id] - the id of the object to delete
  /// ref https://docs.parseplatform.org/rest/guide/#deleting-objects
  delete(String id) async {
    var result = await parseDelete("/classes/$className", id);
    return ParseResult((result.statusCode == 200), jsonDecode(result.body));
  }
}
