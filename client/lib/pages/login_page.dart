import 'package:flutter/material.dart';
import 'package:client/pages/account_page.dart';
import 'package:client/services/user_service.dart';
import 'package:client/models/user_response.dart';
import 'package:client/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  static const route = 'login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserService _userService = UserService();
  final _emailController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresar'),
      ),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 200),
                const SizedBox(height: 50.0),
                textFormField(
                  _emailController,
                  'Correo electrónico',
                  'Introduzca el correo electrónico',
                  Icons.email,
                  "Correo electrónico",
                  TextInputType.emailAddress,
                ),
                const SizedBox(height: 40.0),
                InkWell(
                  onTap: () async {
                    setState(() {
                      circular = true;
                    });
                    await checkUser();
                    if (_globalKey.currentState!.validate()) {
                      if (validate) {
                        User user;
                        user = await _userService.getUser(_emailController.text)
                            as User;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AccountPage(user),
                          ),
                          (_) => false,
                        );
                      } else {
                        setState(() {
                          circular = false;
                        });
                        _showAlert(context);
                      }
                    }
                  },
                  child: circular
                      ? const CircularProgressIndicator()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xff00A86B),
                          ),
                          child: const Center(
                            child: Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkUser() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        circular = false;
      });
    } else {
      final response = await _userService.existUser(_emailController.text);
      setState(() {
        validate = response!;
      });
    }
  }

  _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Center(child: Text('¡El usuario no existe!')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'Por favor, verifique su correo',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              FlutterLogo(
                size: 100.0,
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
