import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends ChangeNotifier {
  static Future<Map<String, dynamic>> sendMessage(
      String name, String message) async {
    Map<String, String> body = {"nome": name, "msg": message};

    http.Response response = await http.post(
      "http://10.0.0.167/unip/recados/api_add.php",
      body: jsonEncode(body),
      encoding: Encoding.getByName("utf-8"),
    );

    return jsonDecode(response.body);
  }
}
