import 'dart:convert';

import 'package:flutter/cupertino.dart' show required;

UserResponse userResponseFromMap(String str) =>
    UserResponse.fromMap(json.decode(str));

String userResponseToMap(UserResponse data) => json.encode(data.toMap());

class UserResponse {
  UserResponse({
    @required this.data,
  });

  final User? data;

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        data: User.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data!.toMap(),
      };
}

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    @required this.accounts,
    @required this.id,
    @required this.name,
    @required this.email,
  });

  final List<Account>? accounts;
  final String? id;
  final String? name;
  final String? email;

  factory User.fromMap(Map<String, dynamic> json) => User(
        accounts:
            List<Account>.from(json["accounts"].map((x) => Account.fromMap(x))),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "accounts": List<dynamic>.from(accounts!.map((x) => x.toMap())),
        "_id": id,
        "name": name,
        "email": email,
      };
}

class Account {
  Account({
    @required this.withdrawals,
    @required this.id,
    @required this.number,
    @required this.type,
    @required this.balance,
    @required this.user,
  });

  final List<String>? withdrawals;
  final String? id;
  final int? number;
  final String? type;
  final int? balance;
  final String? user;

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        withdrawals: List<String>.from(json["withdrawals"].map((x) => x)),
        id: json["_id"],
        number: json["number"],
        type: json["type"],
        balance: json["balance"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "withdrawals": List<dynamic>.from(withdrawals!.map((x) => x)),
        "_id": id,
        "number": number,
        "type": type,
        "balance": balance,
        "user": user,
      };
}

CheckUserResponse checkUserResponseFromMap(String str) =>
    CheckUserResponse.fromMap(json.decode(str));

String checkUserResponseToMap(CheckUserResponse data) =>
    json.encode(data.toMap());

class CheckUserResponse {
  CheckUserResponse({
    @required this.status,
  });

  final bool? status;

  factory CheckUserResponse.fromMap(Map<String, dynamic> json) =>
      CheckUserResponse(
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
      };
}
