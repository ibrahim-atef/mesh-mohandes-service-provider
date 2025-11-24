/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'e_provider_model.dart';
import 'parents/model.dart';

class AvailabilityHour extends Model {
  String? id;
  String? day;
  String? startAt;
  String? endAt;
  late String data;
  EProvider? eProvider;

  AvailabilityHour({this.id, this.day, this.startAt, this.endAt, String? data, this.eProvider}) : data = data ?? '';

  AvailabilityHour.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    day = stringFromJson(json, 'day');
    startAt = stringFromJson(json, 'start_at');
    endAt = stringFromJson(json, 'end_at');
    data = transStringFromJson(json, 'data', defaultValue: '');
    eProvider = objectFromJson(json, 'e_provider', (value) => EProvider.fromJson(value));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (day != null) data['day'] = this.day;
    if (startAt != null) data['start_at'] = this.startAt;
    if (endAt != null) data['end_at'] = this.endAt;
    data['data'] = this.data;
    if (this.eProvider != null) data['e_provider_id'] = this.eProvider!.id;
    return data;
  }

  String toDuration() {
    return '${startAt ?? ''} - ${endAt ?? ''}';
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is AvailabilityHour &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          day == other.day &&
          startAt == other.startAt &&
          endAt == other.endAt &&
          data == other.data &&
          eProvider == other.eProvider;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ day.hashCode ^ startAt.hashCode ^ endAt.hashCode ^ data.hashCode ^ eProvider.hashCode;
}
