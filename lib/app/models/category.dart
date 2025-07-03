import 'package:nylo_framework/nylo_framework.dart';

class Category extends Model {
  String? id;
  String? name;
  String? parentCategoryId;
  String? icon;
  String? color;

  static StorageKey key = 'category';

  Category({
    this.id,
    this.name,
    this.parentCategoryId,
    this.icon,
    this.color,
  }) : super(key: key);

  Category.fromJson(dynamic data) {
    id = data['id'];
    name = data['name'];
    parentCategoryId = data['parentCategoryId'];
    icon = data['icon'];
    color = data['color'];
  }

  @override
  toJson() => {
        "id": id,
        "name": name,
        "parentCategoryId": parentCategoryId,
        "icon": icon,
        "color": color,
      };
}