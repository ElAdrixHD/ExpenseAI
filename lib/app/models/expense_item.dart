import 'package:nylo_framework/nylo_framework.dart';

class ExpenseItem extends Model {
  String? id;
  String? expenseId;
  String? productId;
  String? categoryId;
  String? name;
  double? quantity;
  double? unitPrice;
  double? totalPrice;
  double? taxRate;
  double? discountAmount;

  static StorageKey key = 'expense_item';

  ExpenseItem({
    this.id,
    this.expenseId,
    this.productId,
    this.categoryId,
    this.name,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.taxRate,
    this.discountAmount,
  }) : super(key: key);

  ExpenseItem.fromJson(dynamic data) {
    id = data['id'];
    expenseId = data['expenseId'];
    productId = data['productId'];
    categoryId = data['categoryId'];
    name = data['name'];
    quantity = data['quantity']?.toDouble();
    unitPrice = data['unitPrice']?.toDouble();
    totalPrice = data['totalPrice']?.toDouble();
    taxRate = data['taxRate']?.toDouble();
    discountAmount = data['discountAmount']?.toDouble();
  }

  @override
  toJson() => {
        "id": id,
        "expenseId": expenseId,
        "productId": productId,
        "categoryId": categoryId,
        "name": name,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "totalPrice": totalPrice,
        "taxRate": taxRate,
        "discountAmount": discountAmount,
      };
}