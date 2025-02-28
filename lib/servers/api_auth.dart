import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_restaurant/servers/cach_service.dart';

class ApiAuth {
  CachService cachService = CachService();
  final basUri = 'http://46.101.203.30:8000/';
  Future<bool> singup(String username, String eamil, String password) async {
    final requestbody = {
      "username": username,
      "password": password,
      "email": eamil
    };

    final respons = await http.post(
        Uri.parse(
          basUri + 'register',
        ),
        body: jsonEncode(requestbody),
        headers: {'Content-Type': 'application/json'});

    if (respons.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> longin(String email, String password) async {
    final requestbody = {"password": password, "email": email};

    final respons = await http.post(Uri.parse(basUri + 'login'),body: jsonEncode(requestbody),
        headers: {'Content-Type': 'application/json'});
    if (respons.statusCode == 200) {
      final date = jsonDecode(respons.body);
      cachService.addtoken(date['accessToken']);
      return true;
    } else {
      return false;
    }
  }
}
