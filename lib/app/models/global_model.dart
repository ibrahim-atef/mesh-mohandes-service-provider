import 'parents/model.dart';

class Global extends Model {
  String? mockBaseUrl;
  String? laravelBaseUrl;
  String? apiPath;
  late int received;
  late int accepted;
  late int onTheWay;
  late int ready;
  late int inProgress;
  late int done;
  late int failed;

  Global({this.mockBaseUrl, this.laravelBaseUrl, this.apiPath}) {
    received = 0;
    accepted = 0;
    onTheWay = 0;
    ready = 0;
    inProgress = 0;
    done = 0;
    failed = 0;
  }

  Global.fromJson(Map<String, dynamic> json) {
    mockBaseUrl = json['mock_base_url'].toString();
    laravelBaseUrl = json['laravel_base_url'].toString();
    apiPath = json['api_path'].toString();
    received = intFromJson(json, 'received');
    accepted = intFromJson(json, 'accepted');
    onTheWay = intFromJson(json, 'on_the_way');
    ready = intFromJson(json, 'ready');
    inProgress = intFromJson(json, 'in_progress');
    done = intFromJson(json, 'done');
    failed = intFromJson(json, 'failed');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mock_base_url'] = this.mockBaseUrl;
    data['laravel_base_url'] = this.laravelBaseUrl;
    data['api_path'] = this.apiPath;
    return data;
  }
}
