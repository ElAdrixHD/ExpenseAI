import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/app/models/category.dart';
import '/app/models/expense.dart';
import '/app/models/expense_item.dart';
import '/app/models/merchant.dart';
import '/app/models/product.dart';
import '/app/models/receipt.dart';
import '/app/models/tax.dart';

class ExpenseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static String? get _currentUserId => Auth.data()['id'];

  // Receipt CRUD operations
  static Future<String> createReceipt(Receipt receipt) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    receipt.userId = _currentUserId;
    receipt.createdAt = DateTime.now();
    receipt.id = _db.collection('receipts').doc().id;

    await _db.collection('receipts').doc(receipt.id).set(receipt.toJson());
    return receipt.id!;
  }

  static Future<Receipt?> getReceipt(String receiptId) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    DocumentSnapshot doc =
        await _db.collection('receipts').doc(receiptId).get();
    if (doc.exists && doc.data() != null) {
      return Receipt.fromJson(doc.data());
    }
    return null;
  }

  static Future<List<Receipt>> getUserReceipts() async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    QuerySnapshot query = await _db
        .collection('receipts')
        .where('userId', isEqualTo: _currentUserId)
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs.map((doc) => Receipt.fromJson(doc.data())).toList();
  }

  static Future<void> updateReceipt(Receipt receipt) async {
    if (_currentUserId == null) throw Exception('User not authenticated');
    if (receipt.id == null) throw Exception('Receipt ID is required');

    await _db.collection('receipts').doc(receipt.id).update(receipt.toJson());
  }

  static Future<void> deleteReceipt(String receiptId) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    await _db.collection('receipts').doc(receiptId).delete();
  }

  // Expense CRUD operations
  static Future<String> createExpense(Expense expense) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    expense.userId = _currentUserId;
    expense.createdAt = DateTime.now();
    expense.id = _db.collection('expenses').doc().id;

    await _db.collection('expenses').doc(expense.id).set(expense.toJson());
    return expense.id!;
  }

  static Future<Expense?> getExpense(String expenseId) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    DocumentSnapshot doc =
        await _db.collection('expenses').doc(expenseId).get();
    if (doc.exists && doc.data() != null) {
      return Expense.fromJson(doc.data());
    }
    return null;
  }

  static Future<List<Expense>> getUserExpenses() async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    QuerySnapshot query = await _db
        .collection('expenses')
        .where('userId', isEqualTo: _currentUserId)
        .orderBy('date', descending: true)
        .get();

    return query.docs.map((doc) => Expense.fromJson(doc.data())).toList();
  }

  static Future<void> updateExpense(Expense expense) async {
    if (_currentUserId == null) throw Exception('User not authenticated');
    if (expense.id == null) throw Exception('Expense ID is required');

    await _db.collection('expenses').doc(expense.id).update(expense.toJson());
  }

  static Future<void> deleteExpense(String expenseId) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    await _db.collection('expenses').doc(expenseId).delete();
  }

  // ExpenseItem CRUD operations
  static Future<String> createExpenseItem(ExpenseItem item) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    item.id = _db.collection('expense_items').doc().id;

    await _db.collection('expense_items').doc(item.id).set(item.toJson());
    return item.id!;
  }

  static Future<List<ExpenseItem>> getExpenseItems(String expenseId) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    QuerySnapshot query = await _db
        .collection('expense_items')
        .where('expenseId', isEqualTo: expenseId)
        .get();

    return query.docs.map((doc) => ExpenseItem.fromJson(doc.data())).toList();
  }

  static Future<void> updateExpenseItem(ExpenseItem item) async {
    if (_currentUserId == null) throw Exception('User not authenticated');
    if (item.id == null) throw Exception('ExpenseItem ID is required');

    await _db.collection('expense_items').doc(item.id).update(item.toJson());
  }

  static Future<void> deleteExpenseItem(String itemId) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    await _db.collection('expense_items').doc(itemId).delete();
  }

  // Merchant CRUD operations
  static Future<String> createMerchant(Merchant merchant) async {
    merchant.id = _db.collection('merchants').doc().id;

    await _db.collection('merchants').doc(merchant.id).set(merchant.toJson());
    return merchant.id!;
  }

  static Future<Merchant?> getMerchant(String merchantId) async {
    DocumentSnapshot doc =
        await _db.collection('merchants').doc(merchantId).get();
    if (doc.exists && doc.data() != null) {
      return Merchant.fromJson(doc.data());
    }
    return null;
  }

  static Future<List<Merchant>> getMerchants() async {
    QuerySnapshot query = await _db.collection('merchants').get();
    return query.docs.map((doc) => Merchant.fromJson(doc.data())).toList();
  }

  static Future<Merchant?> findMerchantByName(String name) async {
    QuerySnapshot query = await _db
        .collection('merchants')
        .where('name', isEqualTo: name)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return Merchant.fromJson(query.docs.first.data());
    }
    return null;
  }

  // Category CRUD operations
  static Future<String> createCategory(Category category) async {
    category.id = _db.collection('categories').doc().id;

    await _db.collection('categories').doc(category.id).set(category.toJson());
    return category.id!;
  }

  static Future<Category?> getCategory(String categoryId) async {
    DocumentSnapshot doc =
        await _db.collection('categories').doc(categoryId).get();
    if (doc.exists && doc.data() != null) {
      return Category.fromJson(doc.data());
    }
    return null;
  }

  static Future<List<Category>> getCategories() async {
    QuerySnapshot query = await _db.collection('categories').get();
    return query.docs.map((doc) => Category.fromJson(doc.data())).toList();
  }

  // Product CRUD operations
  static Future<String> createProduct(Product product) async {
    product.id = _db.collection('products').doc().id;

    await _db.collection('products').doc(product.id).set(product.toJson());
    return product.id!;
  }

  static Future<Product?> getProduct(String productId) async {
    DocumentSnapshot doc =
        await _db.collection('products').doc(productId).get();
    if (doc.exists && doc.data() != null) {
      return Product.fromJson(doc.data());
    }
    return null;
  }

  static Future<Product?> findProductByName(String name) async {
    QuerySnapshot query = await _db
        .collection('products')
        .where('normalizedName', isEqualTo: name.toLowerCase())
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return Product.fromJson(query.docs.first.data());
    }
    return null;
  }

  // Tax CRUD operations
  static Future<String> createTax(Tax tax) async {
    tax.id = _db.collection('taxes').doc().id;

    await _db.collection('taxes').doc(tax.id).set(tax.toJson());
    return tax.id!;
  }

  static Future<List<Tax>> getExpenseTaxes(String expenseId) async {
    QuerySnapshot query = await _db
        .collection('taxes')
        .where('expenseId', isEqualTo: expenseId)
        .get();

    return query.docs.map((doc) => Tax.fromJson(doc.data())).toList();
  }

  // Analytics and reporting methods
  static Future<double> getTotalExpensesForPeriod(
      DateTime startDate, DateTime endDate) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    QuerySnapshot query = await _db
        .collection('expenses')
        .where('userId', isEqualTo: _currentUserId)
        .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('date', isLessThanOrEqualTo: endDate.toIso8601String())
        .get();

    double total = 0.0;
    for (var doc in query.docs) {
      var expense = Expense.fromJson(doc.data());
      total += expense.totalAmount ?? 0.0;
    }
    return total;
  }

  static Future<double> getTotalTaxesForPeriod(
      DateTime startDate, DateTime endDate) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    QuerySnapshot query = await _db
        .collection('expenses')
        .where('userId', isEqualTo: _currentUserId)
        .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('date', isLessThanOrEqualTo: endDate.toIso8601String())
        .get();

    double total = 0.0;
    for (var doc in query.docs) {
      var expense = Expense.fromJson(doc.data());
      total += expense.taxAmount ?? 0.0;
    }
    return total;
  }

  static Future<Map<String, double>> getExpensesByCategory(
      DateTime startDate, DateTime endDate) async {
    if (_currentUserId == null) throw Exception('User not authenticated');

    QuerySnapshot expenseQuery = await _db
        .collection('expenses')
        .where('userId', isEqualTo: _currentUserId)
        .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('date', isLessThanOrEqualTo: endDate.toIso8601String())
        .get();

    Map<String, double> categoryTotals = {};

    for (var expenseDoc in expenseQuery.docs) {
      var expense = Expense.fromJson(expenseDoc.data());

      QuerySnapshot itemsQuery = await _db
          .collection('expense_items')
          .where('expenseId', isEqualTo: expense.id)
          .get();

      for (var itemDoc in itemsQuery.docs) {
        var item = ExpenseItem.fromJson(itemDoc.data());
        if (item.categoryId != null) {
          Category? category = await getCategory(item.categoryId!);
          if (category != null) {
            categoryTotals[category.name!] =
                (categoryTotals[category.name!] ?? 0.0) +
                    (item.totalPrice ?? 0.0);
          }
        }
      }
    }

    return categoryTotals;
  }
}
