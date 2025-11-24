import 'parents/model.dart';

class SubscriptionPackage extends Model {
  String? id;
  String? name;
  String? description;
  late double price;
  late double discountPrice;
  late int durationInDays;

  SubscriptionPackage({this.id, this.name, this.description, double? price, double? discountPrice, int? durationInDays})
    : price = price ?? 0.0,
      discountPrice = discountPrice ?? 0.0,
      durationInDays = durationInDays ?? 0;

  SubscriptionPackage.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    durationInDays = intFromJson(json, 'duration_in_days');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (name != null) data['name'] = this.name;
    if (description != null) data['description'] = this.description;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['duration_in_days'] = this.durationInDays;
    return data;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return discountPrice > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return discountPrice > 0 ? price : 0;
  }
}
