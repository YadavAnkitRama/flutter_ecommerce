import 'package:http/http.dart' as http;
import 'dart:convert';

Future registerUser(String name, String email, String password, String phone,
    String address) async {
  String url = 'https://surajyadavapi123.000webhostapp.com/flutter-post.php';
  final response = await http.post(url, headers: {
    "Accept": "Application/json"
  }, body: {
    'Name': name,
    'Email': email,
    'Password': password,
    'Phone': phone,
    'Address': address
  });
  var convertDataJson = jsonDecode(response.body);
  return convertDataJson;
}

Future loginUser(String email, String password) async {
  String url = 'https://surajyadavapi123.000webhostapp.com/flutter-login.php';
  final response = await http.post(url,
      headers: {"Accept": "Application/json"},
      body: {'email': email, 'password': password});
  var convertDataJson = jsonDecode(response.body);
  return convertDataJson;
}
