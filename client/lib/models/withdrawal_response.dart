// To parse this JSON data, do
//
//     final requestWithDrawal = requestWithDrawalFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RequestWithDrawal requestWithDrawalFromMap(String str) => RequestWithDrawal.fromMap(json.decode(str));

String requestWithDrawalToMap(RequestWithDrawal data) => json.encode(data.toMap());

class RequestWithDrawal {
    RequestWithDrawal({
        @required this.amount,
        @required this.account,
    });

    final int? amount;
    final String? account;

    factory RequestWithDrawal.fromMap(Map<String, dynamic> json) => RequestWithDrawal(
        amount: json["amount"],
        account: json["account"],
    );

    Map<String, dynamic> toMap() => {
        "amount": amount,
        "account": account,
    };
}
