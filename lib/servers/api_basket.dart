import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_restaurant/models/basket_item.dart';

class ApiBasket {
  final baseUri = 'http://46.101.203.30:8000/';
  Future<bool> addbasket(String id , int count) async {
    final requstbody = {"id": id, "quantity": count};
    final respons = await http.post(Uri.parse(baseUri + 'basket/$id'),
        body: jsonEncode(requstbody));

    if (respons.statusCode == 201) {
      return true;
    } else {
      throw Exception('حدث خطا ما ');
    }
  }

  Future <List<BasketItem>> getbasket() async {
    final respons = await http.get(Uri.parse(baseUri + 'basket'));
    if (respons.statusCode == 200) {
      final date = jsonDecode(respons.body);
      List <BasketItem> baskets =[];
      for(int i =0 ; i > date.leading ; i++){
        baskets.add(BasketItem.fromjson(date));
        
      }return baskets;
    }else{
      throw Exception('حدث خطا ما ');
    }
  }
}
