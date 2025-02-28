import 'package:flutter/material.dart';
import 'package:search_restaurant/models/basket_item.dart';
import 'package:search_restaurant/pages/checkout.dart';
import 'package:search_restaurant/servers/api_basket.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
   double sum = 0;
  bool islonding = true;
  List<BasketItem> items = [];
  final counts = 0;
  ApiBasket apiBasket = ApiBasket();
  @override
  void initState() {
    super.initState();
    apiBasket.getbasket().then((data) {
      setState(() {
        items = data;
        for (int i =0 ; i< data.length ; i++){
          sum += data[i].price;
        }
        islonding = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY Basket'),
      ),
      body: islonding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                        width: 50,
                                        height: 50,
                                        items[index].image),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(items[index].name),
                                        Text(items[index].quantity.toString())
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text('${items[index].price}\$')
                              ],
                            ),
                          )),
                    );
                  },
                )),
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Total'),
                          Text(sum.toString())
                        ],
                      ),
                      Container(
                          height: 55,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffFFA451)),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Checkout();
                                  },
                                ));
                              },
                              child: Text(
                                'checkout',
                                style: TextStyle(color: Colors.black),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
