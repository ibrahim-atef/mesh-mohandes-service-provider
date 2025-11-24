/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'parents/model.dart';

class EProviderType extends Model {
  String? id;
  String? name;
  late double commission;

  EProviderType({this.id, this.name, double? commission}) : commission = commission ?? 0.0;

  EProviderType.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    commission = doubleFromJson(json, 'commission');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['commission'] = this.commission;
    return data;
  }
}
