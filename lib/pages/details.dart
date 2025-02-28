import 'package:flutter/material.dart';
import 'package:search_restaurant/models/menu_model.dart';
import 'package:search_restaurant/pages/basket_page.dart';
import 'package:search_restaurant/servers/api_basket.dart';

class Details extends StatefulWidget {
  const Details({required this.menuitem, super.key});
  final MenuModel menuitem;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  ApiBasket apiBasket = ApiBasket();
  bool islike = false;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 100.0,
                centerTitle: true,
                background:
                    Image.network(widget.menuitem.image, fit: BoxFit.cover),
              ),
              backgroundColor: Colors.brown,
              expandedHeight: 350.0,
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  widget.menuitem.name,
                  style: TextStyle(
                      color: Color(0xff27214D),
                      fontSize: 24,
                      fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              iconSize: 20,
                              shape: CircleBorder(),
                              side: BorderSide(color: Color(0xff333333))),
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: Color(0xff333333),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$count',
                        style: TextStyle(color: Color(0xff27214D), fontSize: 20),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                        iconSize: 25,
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xffFFF2E7))),
                        onPressed: () {
                          setState(() {
                            if (count > 0) {
                              count--;
                            }
                          });
                        },
                        icon: Icon(Icons.remove),
                        color: Color(0xffFFA451),
                      ),
                      
                    ],
                  ),Text(
                        '${(widget.menuitem.price * count)}\$',
                        style:
                            TextStyle(color: Color(0xff27214D), fontSize: 24),
                      )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Color(0xffF3F3F3),
                thickness: 4,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                ' one pack contains',
                style: TextStyle(fontFamily: 'Roboto', fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 3,
                color: Color(0xffFFA451),
                indent: 4,
                endIndent: 225,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.menuitem.discrption,
                style: TextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 4,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xffFFF2E7))),
                        onPressed: () {
                          setState(() {
                            islike = !islike;
                          });
                        },
                        icon: Icon(
                          islike ? Icons.favorite : Icons.favorite_border,
                          color: Color(0xffFFA451),
                          size: 30,
                        )),
                    Container(
                        height: 55,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffFFA451)),
                        child: TextButton(
                            onPressed: () {
                              apiBasket
                                  .addbasket(widget.menuitem.id, count)
                                  .then((isdone) {
                                    if(isdone){
                                      Navigator.push(context, MaterialPageRoute(builder:(context) {
                                        return BasketPage();
                                      },));
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطا ما ')));
                                    }
                                  });
                            },
                            child: Text('Add to basket '))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
