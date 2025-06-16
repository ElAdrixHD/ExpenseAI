import 'package:nylo_framework/nylo_framework.dart';

class User extends Model {
  String? id;
  String? name;
  String? email;

  static StorageKey key = 'user';

  User({this.id, this.name, this.email}) : super(key: key);

  User.fromJson(dynamic data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
  }

  @override
  toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
