import 'package:nylo_framework/nylo_framework.dart';

class Expense extends Model {
  String? id;
  String? receiptId;
  String? userId;
  String? merchantId;
  double? totalAmount;
  double? subtotalAmount;
  double? taxAmount;
  double? discountAmount;
  DateTime? date;
  String? paymentMethod;
  String? notes;
  DateTime? createdAt;

  static StorageKey key = 'expense';

  Expense({
    this.id,
    this.receiptId,
    this.userId,
    this.merchantId,
    this.totalAmount,
    this.subtotalAmount,
    this.taxAmount,
    this.discountAmount,
    this.date,
    this.paymentMethod,
    this.notes,
    this.createdAt,
  }) : super(key: key);

  Expense.fromJson(dynamic data) {
    id = data['id'];
    receiptId = data['receiptId'];
    userId = data['userId'];
    merchantId = data['merchantId'];
    totalAmount = data['totalAmount']?.toDouble();
    subtotalAmount = data['subtotalAmount']?.toDouble();
    taxAmount = data['taxAmount']?.toDouble();
    discountAmount = data['discountAmount']?.toDouble();
    date = data['date'] != null ? DateTime.parse(data['date']) : null;
    paymentMethod = data['paymentMethod'];
    notes = data['notes'];
    createdAt = data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null;
  }

  @override
  toJson() => {
        "id": id,
        "receiptId": receiptId,
        "userId": userId,
        "merchantId": merchantId,
        "totalAmount": totalAmount,
        "subtotalAmount": subtotalAmount,
        "taxAmount": taxAmount,
        "discountAmount": discountAmount,
        "date": date?.toIso8601String(),
        "paymentMethod": paymentMethod,
        "notes": notes,
        "createdAt": createdAt?.toIso8601String(),
      };
}