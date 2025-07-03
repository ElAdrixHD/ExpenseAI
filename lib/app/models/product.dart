import 'package:nylo_framework/nylo_framework.dart';

class Product extends Model {
  String? id;
  String? name;
  String? normalizedName;
  String? defaultCategoryId;
  String? brand;
  String? description;

  static StorageKey key = 'product';

  Product({
    this.id,
    this.name,
    this.normalizedName,
    this.defaultCategoryId,
    this.brand,
    this.description,
  }) : super(key: key);

  Product.fromJson(dynamic data) {
    id = data['id'];
    name = data['name'];
    normalizedName = data['normalizedName'];
    defaultCategoryId = data['defaultCategoryId'];
    brand = data['brand'];
    description = data['description'];
  }

  @override
  toJson() => {
        "id": id,
        "name": name,
        "normalizedName": normalizedName,
        "defaultCategoryId": defaultCategoryId,
        "brand": brand,
        "description": description,
      };
}