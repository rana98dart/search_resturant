import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:search_restaurant/models/menu_model.dart';
import 'package:search_restaurant/models/menu_param.dart';
import 'package:search_restaurant/pages/details.dart';
import 'package:search_restaurant/servers/api_menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Productcategory> categorys = [
    Productcategory.All,
    Productcategory.Appetizer,
    Productcategory.Beverage,
    Productcategory.Dessert,
    Productcategory.MainCourse,
    Productcategory.Salad,
    Productcategory.SideDish,
    Productcategory.Soup
  ];

  MenuParam Param = MenuParam(name: '', category: '');
  ApiMenu apiMenu = ApiMenu();

  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.short_text,
            color: Color(0xff070648),
            size: 44,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SvgPicture.asset(
                    './lib/assets/photos/Group25.svg',
                    width: 28,
                    height: 28,
                  )
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                './lib/assets/fonts/do you want today.svg',
                width: 257,
                height: 58,
              )
              // RichText(
              //     text: TextSpan(style: TextStyle(fontSize: 16), children: [
              //   TextSpan(
              //       text: 'Hello Tony,',
              //       style: TextStyle(color: Color(0xff070648))),
              //   TextSpan(
              //       text: 'What fruit salad ',
              //       style: TextStyle(color: Color(0xff070648))),
              //   TextSpan(
              //       text:
              //           '                                                        '),
              //   TextSpan(
              //       text: 'combo do you want today?',
              //       style: TextStyle(color: Color(0xff070648)))
              // ])),
              ,
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                Param = MenuParam(
                                    name: value, category: Param.category);
                              });
                            },
                            decoration: InputDecoration(

                                // enabledBorder: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xffF3F4F9),
                                prefixIcon: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: Icon(
                                    Icons.search,
                                    color: Color(0xffbac86869E),
                                  ),
                                ),
                                hintText: 'Search for fruit salad combos',
                                hintStyle:
                                    TextStyle(color: Color(0xffbac86869E)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey))),
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categorys.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Param = MenuParam(
                                              name: Param.name,
                                              category: categorys[index] ==
                                                      Productcategory.All
                                                  ? ''
                                                  : categorys[index].name);
                                        });
                                      },
                                      child: Text(categorys[index].name,
                                          style: TextStyle(
                                            color: (Param.category ==
                                                        categorys[index].name ||
                                                    (Param.category == '' &&
                                                        categorys[index] ==
                                                            Productcategory
                                                                .All))
                                                ? Color(0xff0070648)
                                                : Color(0xff938DB5),
                                          )),
                                    ));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45),
                    child: SvgPicture.asset(
                      './lib/assets/photos/Group6.svg',
                      width: 26,
                      height: 17,
                    ),
                  )
                ],
              ),
              FutureBuilder(
                future: apiMenu.getmenu(Param),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.active) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder:(context) {
                                      return Details(menuitem: snapshot.data![index] )
                                      ;
                                    },));
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0.5, top: 25),
                                            child: ClipOval(
                                              child: Image.network(
                                                snapshot.data![index].image
                                                  ,width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 130,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0.5, top: 50),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data![index].name,
                                                ),
                                                Text(
                                                  snapshot.data![index].price
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                    snapshot.data![index].category
                                                        .name,
                                                    style: TextStyle())
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ));
  }
}
