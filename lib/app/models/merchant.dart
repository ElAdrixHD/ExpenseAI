import 'package:nylo_framework/nylo_framework.dart';

class Merchant extends Model {
  String? id;
  String? name;
  String? address;
  String? phone;
  String? category;
  String? taxId;

  static StorageKey key = 'merchant';

  Merchant({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.category,
    this.taxId,
  }) : super(key: key);

  Merchant.fromJson(dynamic data) {
    id = data['id'];
    name = data['name'];
    address = data['address'];
    phone = data['phone'];
    category = data['category'];
    taxId = data['taxId'];
  }

  @override
  toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "category": category,
        "taxId": taxId,
      };
}