import 'package:flutter/material.dart';
import 'package:search_restaurant/servers/api_basket.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  ApiBasket apiBasket = ApiBasket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY Basket'),
      ),
      body: FutureBuilder(
        future: apiBasket.getbasket(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Image.network(snapshot.data![index].image),
                          Column(
                            children: [
                              Text(snapshot.data![index].name),
                              Text(snapshot.data![index].quantity.toString())
                            ],
                          ),
                          Text('${snapshot.data![index].price}\$')
                        ],
                      ));
                },
              );
            }
          }
          if (snapshot.hasError) {
            return Text(snapshot.hasError.toString());
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
