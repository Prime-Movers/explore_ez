// ignore_for_file: depend_on_referenced_packages

import 'package:http/http.dart' as http;

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  if (response.body == null) {
    return {};
  }
  return response.body;
}