import 'package:client/models/user_response.dart';
import 'package:client/pages/account_page.dart';
import 'package:client/services/account_service.dart';
import 'package:client/services/user_service.dart';
import 'package:client/services/withdrawal_service.dart';
import 'package:client/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class WithdrawalPage extends StatefulWidget {
  static const route = 'withdrawal';
  final User? user;
  final Account? account;

  // ignore: use_key_in_widget_constructors
  const WithdrawalPage(this.user, this.account)
      : assert(user != null || account != null);

  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final AccountService _accountService = AccountService();
  final UserService _userService = UserService();
  final WithdrawalService _withdrawalService = WithdrawalService();
  final _amountController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retiro de dinero'),
      ),
      body: widget.account!.balance! == 0
          ? const Center(
              child: Text(
              '¡No dispone de saldo!',
              style: TextStyle(fontSize: 30),
            ))
          : Form(
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
                        _amountController,
                        'Monto a retirar',
                        'Introduzca el monto a retirar',
                        Icons.money,
                        "Monto a retirar",
                        TextInputType.number,
                      ),
                      const SizedBox(height: 40.0),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            circular = true;
                          });
                          await checkBalance();
                          if (_globalKey.currentState!.validate()) {
                            if (validate) {
                              await _withdrawalService.registerWithdrawal(
                                  int.parse(_amountController.text),
                                  widget.account!.id!);
                              User user;
                              user = await _userService
                                  .getUserById(widget.account!.user!) as User;
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
                                    'Retirar dinero',
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

  checkBalance() async {
    if (_amountController.text.isEmpty) {
      setState(() {
        circular = false;
      });
    } else {
      final response = await _accountService.checkBalance(
          widget.account!.number!, int.parse(_amountController.text));
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
          title: const Center(
              child: Text('¡El monto supera al saldo en su cuenta!')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'Retire un monto menor',
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
