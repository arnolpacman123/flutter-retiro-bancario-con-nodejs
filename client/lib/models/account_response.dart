// To parse this JSON data, do
//
//     final checkBalanceResponse = checkBalanceResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CheckBalanceResponse checkBalanceResponseFromMap(String str) => CheckBalanceResponse.fromMap(json.decode(str));

String checkBalanceResponseToMap(CheckBalanceResponse data) => json.encode(data.toMap());

class CheckBalanceResponse {
    CheckBalanceResponse({
        @required this.status,
    });

    final bool? status;

    factory CheckBalanceResponse.fromMap(Map<String, dynamic> json) => CheckBalanceResponse(
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
    };
}
