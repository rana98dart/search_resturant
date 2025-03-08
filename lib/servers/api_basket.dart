import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_restaurant/models/basket_item.dart';
import 'package:search_restaurant/servers/cach_service.dart';

class ApiBasket {
  CachService cachService = CachService();
  final baseUri = 'http://46.101.203.30:8000/';
  Future<bool> addbasket(String id, int count) async {
    final token = await cachService.gettoken();
    final requstbody = {"id": id, "quantity": count};
    final respons = await http.post(Uri.parse(baseUri + 'basket'),
        body: jsonEncode(requstbody),
        headers: {
          'Content-Type': 'application/json',
         
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (respons.statusCode == 201) {
      return true;
    } else {
      throw Exception('حدث خطا ما ');
    }
  }

  Future<List<BasketItem>> getbasket() async {
    final token = await cachService.gettoken();
    final respons = await http.get(Uri.parse(baseUri + 'basket'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (respons.statusCode == 200) {
      final date = jsonDecode(respons.body);
      List<BasketItem> baskets = [];
      for (int i = 0; i < date.length; i++) {
        baskets.add(BasketItem.fromjson(date[i]));
      }
      return baskets;
    } else {
      throw Exception('حدث خطا ما ');
    }
  }
}
