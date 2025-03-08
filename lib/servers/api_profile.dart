import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_restaurant/models/profile_model.dart';
import 'package:search_restaurant/servers/cach_service.dart';

class ApiProfile {
   CachService cachService = CachService();
  final baseUri = 'http://46.101.203.30:8000/';

  Future<ProfileModel> getprofile() async {
     final token = await  cachService.gettoken();
    final respons = await http.get(Uri.parse(baseUri + 'profile'),headers: 
    {'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'},
    );
    if (respons.statusCode == 200) {
      final data = jsonDecode(respons.body);
      return ProfileModel.fromjson(data);
    } else {
      throw Exception('حدث خطا ');
    }
  }
}
