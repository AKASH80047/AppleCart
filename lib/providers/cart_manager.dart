import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/products.dart';

class CartItem {
  final Product product;
  final String selectedColor;
  final String selectedStorage;
  int quantity;

  CartItem({
    required this.product,
    this.selectedColor = "Default",
    this.selectedStorage = "Default",
    this.quantity = 1,
  });
}

class CartManager extends ChangeNotifier {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  CartManager._internal() {
    // Pre-populate with initial items from the design mockup
    try {
      final iphone = products.firstWhere((p) => p.id == "1");
      _items.add(CartItem(
        product: iphone,
        selectedColor: "White Titanium",
        selectedStorage: "256 GB",
        quantity: 1,
      ));
    } catch (_) {}

    try {
      final macbook = products.firstWhere((p) => p.id == "5");
      _items.add(CartItem(
        product: macbook,
        selectedColor: "Midnight",
        selectedStorage: "512 GB",
        quantity: 1,
      ));
    } catch (_) {}
  }

  void add(
    Product product, {
    String color = "Default",
    String storage = "Default",
    int qty = 1,
  }) {
    final index = _items.indexWhere(
      (e) =>
          e.product.id == product.id &&
          e.selectedColor == color &&
          e.selectedStorage == storage,
    );

    if (index != -1) {
      _items[index].quantity += qty;
    } else {
      _items.add(CartItem(
        product: product,
        selectedColor: color,
        selectedStorage: storage,
        quantity: qty,
      ));
    }

    notifyListeners();
  }

  void remove(Product product) {
    _items.removeWhere((e) => e.product.id == product.id);
    notifyListeners();
  }

  void increase(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrease(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
