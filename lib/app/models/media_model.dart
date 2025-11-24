/*
 * Copyright (c) 2020 .
 */

import 'package:get/get.dart';

import '../services/global_service.dart';
import 'parents/model.dart';

class Media extends Model {
  @override
  String? id;
  late String name;
  late String url;
  late String thumb;
  late String icon;
  late String size;

  Media({String? id, String? url, String? thumb, String? icon}) {
    this.id = id ?? "";
    this.name = "";
    this.url = url ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.thumb = thumb ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.icon = icon ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.size = "";
  }

  Media.fromJson(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id']?.toString() ?? "";
      name = jsonMap['name']?.toString() ?? "";
      url = jsonMap['url']?.toString() ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      thumb = jsonMap['thumb']?.toString() ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      icon = jsonMap['icon']?.toString() ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      size = jsonMap['formatted_size']?.toString() ?? "";
    } catch (e) {
      id = "";
      name = "";
      url = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      thumb = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      icon = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      size = "";
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["icon"] = icon;
    map["formatted_size"] = size;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Media &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          url == other.url &&
          thumb == other.thumb &&
          icon == other.icon &&
          size == other.size;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ url.hashCode ^ thumb.hashCode ^ icon.hashCode ^ size.hashCode;
}
