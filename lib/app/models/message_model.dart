import 'parents/model.dart';
import 'user_model.dart';

class Message extends Model {
  @override
  String? id;

  // conversation name for example chat with market name
  late String name;

  // Chats messages
  late String lastMessage;

  late int lastMessageTime;

  // Ids of users that read the chat message
  late List<String> readByUsers;

  // Ids of users in this conversation
  late List<String> visibleToUsers;

  // users in the conversation
  late List<User> users;

  Message(this.users, {String? id, String? name}) {
    this.id = id ?? '';
    this.name = name ?? '';
    visibleToUsers = this.users.map((user) => user.id ?? '').where((id) => id.isNotEmpty).toList();
    readByUsers = [];
    lastMessage = '';
    lastMessageTime = 0;
  }

  Message.fromDocumentSnapshot(dynamic jsonMap) {
    try {
      // Firebase removed - this method may need to be updated if used
      if (jsonMap is Map<String, dynamic>) {
        id = jsonMap['id']?.toString() ?? '';
        name = jsonMap['name']?.toString() ?? '';
        readByUsers = jsonMap['read_by_users'] != null ? List<String>.from(jsonMap['read_by_users']) : [];
        visibleToUsers = jsonMap['visible_to_users'] != null ? List<String>.from(jsonMap['visible_to_users']) : [];
        lastMessage = jsonMap['message']?.toString() ?? '';
        lastMessageTime = jsonMap['time'] != null ? jsonMap['time'] as int : 0;
        users = jsonMap['users'] != null
            ? List.from(jsonMap['users']).map((element) {
                if (element is Map<String, dynamic>) {
                  element['media'] = [
                    {'thumb': element['thumb']}
                  ];
                  return User.fromJson(element);
                }
                return User();
              }).toList()
            : [];
      } else {
        // Fallback for other types
        id = '';
        name = '';
        readByUsers = [];
        users = [];
        lastMessage = '';
        lastMessageTime = 0;
      }
    } catch (e) {
      id = '';
      name = '';
      readByUsers = [];
      users = [];
      lastMessage = '';
      lastMessageTime = 0;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["users"] = users.map((element) => element.toRestrictMap()).toSet().toList();
    map["visible_to_users"] = users.map((element) => element.id ?? '').where((id) => id.isNotEmpty).toSet().toList();
    map["read_by_users"] = readByUsers;
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    return map;
  }

  Map<String, dynamic> toUpdatedMap() {
    var map = new Map<String, dynamic>();
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    map["read_by_users"] = readByUsers;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is Message &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          lastMessage == other.lastMessage &&
          lastMessageTime == other.lastMessageTime &&
          readByUsers == other.readByUsers &&
          visibleToUsers == other.visibleToUsers &&
          users == other.users;

  @override
  int get hashCode =>
      super.hashCode ^ id.hashCode ^ name.hashCode ^ lastMessage.hashCode ^ lastMessageTime.hashCode ^ readByUsers.hashCode ^ visibleToUsers.hashCode ^ users.hashCode;
}
