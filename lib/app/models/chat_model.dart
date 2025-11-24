import 'package:flutter/material.dart';

import "parents/model.dart";
import 'user_model.dart';

class Chat extends Model {
  @override
  String? id;

  // message text
  late String text;

  // time of the message
  late int time;

  // user id who send the message
  String? userId;

  User? user;

  Chat(this.text, this.time, this.userId, this.user);

  Chat.fromDocumentSnapshot(dynamic jsonMap) {
    try {
      // Firebase removed - this method may need to be updated if used
      if (jsonMap is Map<String, dynamic>) {
        id = jsonMap['id']?.toString() ?? UniqueKey().toString();
        text = jsonMap['text']?.toString() ?? '';
        time = jsonMap['time'] != null ? jsonMap['time'] as int : 0;
        userId = jsonMap['user']?.toString();
      } else {
        // Fallback for other types
        id = UniqueKey().toString();
        text = '';
        time = 0;
        user = null;
        userId = null;
      }
    } catch (e) {
      id = UniqueKey().toString();
      text = '';
      time = 0;
      user = null;
      userId = null;
      print(e);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["text"] = text;
    map["time"] = time;
    map["user"] = userId;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other && other is Chat && runtimeType == other.runtimeType && id == other.id && text == other.text && time == other.time && userId == other.userId;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ text.hashCode ^ time.hashCode ^ userId.hashCode;
}
