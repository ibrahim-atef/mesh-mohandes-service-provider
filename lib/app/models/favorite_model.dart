import 'e_service_model.dart';
import 'option_model.dart';
import 'parents/model.dart';

class Favorite extends Model {
  String? id;
  EService? eService;
  late List<Option> options;
  String? userId;

  Favorite({this.id, this.eService, List<Option>? options, this.userId}) : options = options ?? const [];

  Favorite.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    eService = objectFromJson(json, 'e_service', (v) => EService.fromJson(v));
    options = listFromJson(json, 'options', (v) => Option.fromJson(v));
    userId = stringFromJson(json, 'user_id');
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    if (id != null) map["id"] = id;
    if (eService?.id != null) map["e_service_id"] = eService!.id;
    if (userId != null) map["user_id"] = userId;
    if (options is List<Option>) {
      map["options"] = options.map((element) => element.id).where((id) => id != null).toList();
    }
    return map;
  }
}
