import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff00A86B),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (_) => const HomePage(),
        LoginPage.route: (_) => const LoginPage(),
      },
      home: const HomePage(),
    );
  }
}
