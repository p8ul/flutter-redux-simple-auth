import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

typedef  Function FailCallback();

Future<Login> apiClient(String url, Map jsonMap, FailCallback callback) async {
  final response =
      await http.post(url, body: jsonMap);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Login.fromJson(json.decode(response.body));
  } else {
    callback();
    // If that call was not successful, throw an error.
    // throw Exception('Failed to login');
  }
}
