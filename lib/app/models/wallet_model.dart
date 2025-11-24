import 'dart:math';

import '../../common/uuid.dart';
import 'parents/model.dart';

class Wallet extends Model {
  String? id;
  String? name;
  late double balance;

  Wallet({this.id, this.name, double? balance}) : balance = balance ?? 0.0;

  Wallet.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = stringFromJson(json, 'name');
    balance = doubleFromJson(json, 'balance');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) {
      data['id'] = this.id;
    }
    if (name != null) {
      data['name'] = this.name;
    }
    data['balance'] = this.balance;
    return data;
  }

  String getName() {
    String nameValue = name ?? "";
    return nameValue.substring(nameValue.length - min(nameValue.length, 16), nameValue.length);
  }

  String getId() {
    String? idValue = id;
    if (idValue != null && Uuid.isUuid(idValue)) {
      return idValue.substring(0, 3) + ' . . . ' + idValue.substring(idValue.length - 5, idValue.length);
    } else {
      return idValue ?? '';
    }
  }
}
