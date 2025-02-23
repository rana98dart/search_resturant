import 'package:flutter/material.dart';
import 'package:search_restaurant/pages/menu_page.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatefulWidget {
  const _MyApp({super.key});

  @override
  State<_MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}
