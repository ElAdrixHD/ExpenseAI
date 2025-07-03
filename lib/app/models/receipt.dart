import 'package:nylo_framework/nylo_framework.dart';

class Receipt extends Model {
  String? id;
  String? userId;
  String? imageUrl;
  String? originalText;
  DateTime? processedAt;
  DateTime? createdAt;
  String? status;

  static StorageKey key = 'receipt';

  Receipt({
    this.id,
    this.userId,
    this.imageUrl,
    this.originalText,
    this.processedAt,
    this.createdAt,
    this.status,
  }) : super(key: key);

  Receipt.fromJson(dynamic data) {
    id = data['id'];
    userId = data['userId'];
    imageUrl = data['imageUrl'];
    originalText = data['originalText'];
    processedAt = data['processedAt'] != null ? DateTime.parse(data['processedAt']) : null;
    createdAt = data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null;
    status = data['status'];
  }

  @override
  toJson() => {
        "id": id,
        "userId": userId,
        "imageUrl": imageUrl,
        "originalText": originalText,
        "processedAt": processedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "status": status,
      };
}