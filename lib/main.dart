import 'package:flutter/material.dart';
import 'package:newsto/laptopPage.dart';
import 'package:newsto/login_sto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, WidgetBuilder> routers = {
    "/laptopPage": (context) => laptopPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_s(),
      initialRoute: "/",
      routes: routers,
    );
  }
}
