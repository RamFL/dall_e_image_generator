import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_key.dart';

class ApiService {
  static final url = Uri.parse("https://api.openai.com/v1/images/generations");

  static final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $openAIAPIKey",
  };

  static generateImage(String text, String size) async {
    var res = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"prompt": text, "n": 2, "size": size}),
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      return data['data'][0]['url'].toString();
    } else {
      print("Failed to fetch image");
    }
  }
}
