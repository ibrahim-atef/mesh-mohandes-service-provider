import 'parents/model.dart';

class PaymentStatus extends Model {
  String? id;
  String? status;
  late int order;

  PaymentStatus({this.id, this.status, int? order}) : order = order ?? 0;

  PaymentStatus.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    status = transStringFromJson(json, 'status');
    order = intFromJson(json, 'order');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['order'] = this.order;
    return data;
  }
}
