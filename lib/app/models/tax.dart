import 'package:nylo_framework/nylo_framework.dart';

class Tax extends Model {
  String? id;
  String? expenseId;
  String? taxType;
  double? taxRate;
  double? taxableAmount;
  double? taxAmount;

  static StorageKey key = 'tax';

  Tax({
    this.id,
    this.expenseId,
    this.taxType,
    this.taxRate,
    this.taxableAmount,
    this.taxAmount,
  }) : super(key: key);

  Tax.fromJson(dynamic data) {
    id = data['id'];
    expenseId = data['expenseId'];
    taxType = data['taxType'];
    taxRate = data['taxRate']?.toDouble();
    taxableAmount = data['taxableAmount']?.toDouble();
    taxAmount = data['taxAmount']?.toDouble();
  }

  @override
  toJson() => {
        "id": id,
        "expenseId": expenseId,
        "taxType": taxType,
        "taxRate": taxRate,
        "taxableAmount": taxableAmount,
        "taxAmount": taxAmount,
      };
}