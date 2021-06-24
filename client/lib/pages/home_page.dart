import 'package:flutter/material.dart';
import 'package:client/pages/login_page.dart';

class HomePage extends StatelessWidget {
  static const String route = 'home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Retiro bancario')),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xff00A86B),
          ),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(LoginPage.route);
              },
              child: const Text(
                'Ingresar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
