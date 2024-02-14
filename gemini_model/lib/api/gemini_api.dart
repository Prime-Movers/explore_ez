import 'dart:convert';

import 'package:http/http.dart' as http;

class GeminiAPI {
  static Future<Map<String, String>> getHeader() async {
    return {
      'Content-Type': 'application/json',
    };
  }

  static Future<String> getGeminiData(message) async {
    try {
      final header = await getHeader();

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': 'user message request here $message'}
            ]
          }
        ],
        'generationConfig': {'temperature': 0.5, 'maxOutputTokens': 1000}
      };

      String url =
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyB1OICYjUzxVZIrkO7texsBGw-ZeK-4K_s';
      var response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse['candidate'][0]['content']['parts'][0]['text'];
      } else {
        return '';
      }
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }
}
