import 'dart:convert';

class JsonListConverter {
  static List<T> fromJsonList<T>(
    String jsonString,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static String toJsonList<T>(
      List<T> list, Map<String, dynamic> Function(T) toJson) {
    return json.encode(List<dynamic>.from(list.map(toJson)));
  }

  static String toJson<T>(T item, Map<String, dynamic> Function(T) toJson) =>
      json.encode(toJson(item));
}
