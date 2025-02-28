import 'package:flutter/material.dart';
import 'package:search_restaurant/pages/login_page.dart';
import 'package:search_restaurant/pages/singup_page.dart';
import 'package:search_restaurant/pages/menu_page.dart';
import 'package:search_restaurant/servers/cach_service.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatefulWidget {
  const _MyApp({super.key});

  @override
  State<_MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  CachService cachService = CachService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: cachService.gettoken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return MenuPage();
                } else {
                  return LoginPage();
                }
              } 
            }));
  }
}
