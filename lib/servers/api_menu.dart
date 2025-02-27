import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_restaurant/models/menu_model.dart';
import 'package:search_restaurant/models/menu_param.dart';

class ApiMenu {
  final baseUri = 'http://46.101.203.30:8000/';
  Future<List<MenuModel>> getmenu(MenuParam param) async {
    final respons = await http.get(Uri.parse(baseUri+'menu?category=${param.category}&name=${param.name}'
    ));
    if (respons.statusCode == 200) {
      final date = jsonDecode(respons.body) as List;
      List<MenuModel> datemenu = [];
      for (int i = 0; i < date.length; i++) {
        datemenu.add(MenuModel.fromjson(date[i]));
      }
      return datemenu;
    } else {
      throw Exception('field in data ');
    }
  }
}
