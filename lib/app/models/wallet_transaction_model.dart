import 'dart:math';

import 'parents/model.dart';
import 'user_model.dart';

enum TransactionActions { CREDIT, DEBIT }

class WalletTransaction extends Model {
  String? id;
  late double amount;
  String? description;
  late TransactionActions action;
  DateTime? dateTime;
  User? user;

  WalletTransaction({this.id, double? amount, this.description, TransactionActions? action, this.user})
    : amount = amount ?? 0.0,
      action = action ?? TransactionActions.CREDIT;

  WalletTransaction.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = stringFromJson(json, 'description');
    amount = doubleFromJson(json, 'amount');
    user = objectFromJson(json, 'user', (value) => User.fromJson(value));
    dateTime = dateFromJson(json, 'created_at');
    if (json['action'] == 'credit') {
      action = TransactionActions.CREDIT;
    } else if (json['action'] == 'debit') {
      action = TransactionActions.DEBIT;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['action'] = this.action;
    data['user'] = this.user;
    return data;
  }

  String getDescription() {
    String desc = description ?? "";
    return desc.substring(desc.length - min(desc.length, 20), desc.length);
  }
}
