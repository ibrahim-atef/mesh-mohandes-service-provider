import 'package:get/get.dart';

import 'parents/model.dart';

class Notification extends Model {
  String? id;
  String? type;
  Map<String, dynamic>? data;
  late bool read;
  DateTime? createdAt;

  Notification() {
    this.id = null;
    this.type = null;
    this.data = null;
    this.read = false;
    this.createdAt = null;
  }

  Notification.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    type = stringFromJson(json, 'type');
    data = mapFromJson(json, 'data');
    read = boolFromJson(json, 'read_at');
    createdAt = dateFromJson(json, 'created_at', defaultValue: DateTime.now().toLocal()) ?? DateTime.now().toLocal();
  }

  Map markReadMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["read_at"] = !read;
    return map;
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  String getMessage() {
    if (type == 'App\\Notifications\\NewMessage' && data != null) {
      return (data!['from']?.toString() ?? '') + ' ' + (type ?? '').tr;
    } else {
      return (type ?? '').tr;
    }
  }
}
