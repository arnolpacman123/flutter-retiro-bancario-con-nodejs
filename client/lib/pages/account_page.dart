import 'package:client/models/user_response.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/withdrawal_page.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  static const route = 'account';
  final User? user;
  // ignore: use_key_in_widget_constructors
  const AccountPage(this.user) : assert(user != null);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user!.name!),
      ),
      body: Center(
        child: ListView(
          children: _accountList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Salir'),
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.route, (_) => false);
        },
        backgroundColor: const Color(0xff00A86B),
      ),
    );
  }

  List<Widget> _accountList() {
    final list = <Widget>[];
    for (Account account in widget.user!.accounts!) {
      list.add(
        ListTile(
          title: Text('NÚMERO DE CUENTA: ${account.number!}'),
          subtitle: Text('TIPO: ${account.type!} - SALDO: ${account.balance!}'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => WithdrawalPage(widget.user!, account),
              ),
            );
          },
        ),
      );
    }
    return list;
  }
}
