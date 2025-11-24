import 'package:get/get.dart';

import '../../common/uuid.dart';
import 'category_model.dart';
import 'e_provider_model.dart';
import 'media_model.dart';
import 'parents/model.dart';

class EService extends Model {
  String? id;
  String? name;
  String? description;
  late List<Media> images;
  late double price;
  late double discountPrice;
  String? priceUnit;
  String? quantityUnit;
  late double rate;
  late int totalReviews;
  String? duration;
  late bool featured;
  late bool enableBooking;
  late bool isFavorite;
  late List<Category> categories;
  late List<Category> subCategories;
  EProvider? eProvider;

  EService(
      {this.id,
      this.name,
      this.description,
      this.images = const [],
      this.price = 0.0,
      this.discountPrice = 0.0,
      this.priceUnit,
      this.quantityUnit,
      this.rate = 0.0,
      this.totalReviews = 0,
      this.duration,
      this.featured = false,
      this.enableBooking = false,
      this.isFavorite = false,
      this.categories = const [],
      this.subCategories = const [],
      this.eProvider});

  EService.fromJson(Map<String, dynamic> json) {
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    priceUnit = stringFromJson(json, 'price_unit');
    quantityUnit = transStringFromJson(json, 'quantity_unit');
    rate = doubleFromJson(json, 'rate');
    totalReviews = intFromJson(json, 'total_reviews');
    duration = stringFromJson(json, 'duration');
    featured = boolFromJson(json, 'featured');
    enableBooking = boolFromJson(json, 'enable_booking');
    isFavorite = boolFromJson(json, 'is_favorite');
    categories = listFromJson<Category>(json, 'categories', (value) => Category.fromJson(value));
    subCategories = listFromJson<Category>(json, 'sub_categories', (value) => Category.fromJson(value));
    eProvider = objectFromJson(json, 'e_provider', (value) => EProvider.fromJson(value));
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    if (priceUnit != null) data['price_unit'] = this.priceUnit;
    if (quantityUnit != null && quantityUnit != 'null') data['quantity_unit'] = this.quantityUnit;
    data['rate'] = this.rate;
    data['total_reviews'] = this.totalReviews;
    if (duration != null) data['duration'] = this.duration;
    data['featured'] = this.featured;
    data['enable_booking'] = this.enableBooking;
    data['is_favorite'] = this.isFavorite;
    if (this.categories.isNotEmpty) {
      data['categories'] = this.categories.map((v) => v?.id).toList();
    }
    if (this.images.isNotEmpty) {
      data['image'] = this.images.where((element) => Uuid.isUuid(element.id ?? '')).map((v) => v.id ?? '').toList();
    }
    if (this.subCategories.isNotEmpty) {
      data['sub_categories'] = this.subCategories.map((v) => v.toJson()).toList();
    }
    if (this.eProvider != null && this.eProvider!.hasData) {
      data['e_provider_id'] = this.eProvider!.id;
    }
    return data;
  }

  String get firstImageUrl => this.images.isNotEmpty ? (this.images.first.url ?? '') : '';

  String get firstImageThumb => this.images.isNotEmpty ? (this.images.first.thumb ?? '') : '';

  String get firstImageIcon => this.images.isNotEmpty ? (this.images.first.icon ?? '') : '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price : 0;
  }

  String get getUnit {
    if (priceUnit == 'fixed') {
      if (quantityUnit != null && quantityUnit!.isNotEmpty) {
        return "/" + quantityUnit!.tr;
      } else {
        return "";
      }
    } else {
      return "/h".tr;
    }
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is EService &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          rate == other.rate &&
          isFavorite == other.isFavorite &&
          enableBooking == other.enableBooking &&
          categories == other.categories &&
          subCategories == other.subCategories &&
          eProvider == other.eProvider;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      rate.hashCode ^
      eProvider.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;
}
