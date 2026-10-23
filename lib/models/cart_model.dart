import 'package:flutter/foundation.dart';
import 'product.dart';

/// Keranjang belanja (singleton sederhana, tanpa package tambahan).
class CartModel extends ChangeNotifier {
  CartModel._();
  static final CartModel instance = CartModel._();

  final Map<String, int> _qty = {};
  final Map<String, Product> _products = {};

  int qtyOf(Product p) => _qty[p.id] ?? 0;

  /// Mengembalikan false jika stok sudah habis.
  bool add(Product p) {
    final q = qtyOf(p);
    if (q >= p.stock) return false;
    _qty[p.id] = q + 1;
    _products[p.id] = p;
    notifyListeners();
    return true;
  }

  void remove(Product p) {
    final q = qtyOf(p);
    if (q <= 0) return;
    if (q == 1) {
      _qty.remove(p.id);
      _products.remove(p.id);
    } else {
      _qty[p.id] = q - 1;
    }
    notifyListeners();
  }

  int get totalItems => _qty.values.fold(0, (a, b) => a + b);

  int get totalPrice =>
      _qty.entries.fold(0, (s, e) => s + _products[e.key]!.price * e.value);

  List<MapEntry<Product, int>> get lines =>
      _qty.entries.map((e) => MapEntry(_products[e.key]!, e.value)).toList();
}
