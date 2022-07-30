import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant/Helpers/secure_storage.dart';
import 'package:restaurant/Models/Response/ResponseLogin.dart';
import 'package:restaurant/Services/url.dart';

class AuthController {
  Future<ResponseLogin> loginController(String email, String password) async {
    final response = await http.post(Uri.parse('${URLS.URL_API}/users/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    print(response.body);
    return ResponseLogin.fromJson(jsonDecode(response.body));
  }

  Future<ResponseLogin> renewLoginController() async {
    final token = await secureStorage.readToken();
    final response = await http
        .post(Uri.parse('${URLS.URL_API}/users/renew-token'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return ResponseLogin.fromJson(jsonDecode(response.body));
  }
}

final authController = AuthController();
