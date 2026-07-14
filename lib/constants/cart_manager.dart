import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double originalPrice;
  final String imagePath;

  final double rating;
  final String reviewsCount;
  final List<String> availableColors;
  final List<String> availableStorage;
  final List<String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.imagePath,
    required this.rating,
    required this.reviewsCount,
    required this.availableColors,
    required this.availableStorage,
    required this.specs,
  });
}

class CartItem {
  final Product product;
  String selectedColor;
  String selectedStorage;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedColor,
    required this.selectedStorage,
    required this.quantity,
  });
}

class CartManager extends ValueNotifier<List<CartItem>> {
  CartManager() : super([]) {
    // Pre-populate with the items from the design mockup
    value = [
      CartItem(
        product: catalog[0], // iPhone 16 Pro Max
        selectedColor: "Natural Titanium",
        selectedStorage: "512 GB",
        quantity: 1,
      ),
      CartItem(
        product: catalog[1], // Smartwatch Ultra
        selectedColor: "Black",
        selectedStorage: "Default",
        quantity: 1,
      ),
    ];
  }

  // Static product catalog
  static const List<Product> catalog = [
    Product(
      id: "iphone_16_pro_max",
      name: "iPhone 16 Pro Max",
      brand: "Apple",
      price: 1399.99,
      originalPrice: 1499.99,
      imagePath: "assets/images/iPhone1.jpg",
      rating: 4.9,
      reviewsCount: "2.2k",
      availableColors: [
        "Desert Titanium",
        "Natural Titanium",
        "White Titanium",
        "Black Titanium",
      ],
      availableStorage: ["256 GB", "512 GB", "1 TB"],
      specs: ["4K Ultra HD XDR Display", "Wireless Charging System"],
    ),
    Product(
      id: "smartwatch_ultra",
      name: "Smartwatch Ultra",
      brand: "Apple",
      price: 99.99,
      originalPrice: 129.99,
      imagePath: "assets/images/SmartwatchUltra.png",
      rating: 4.8,
      reviewsCount: "1.5k",
      availableColors: ["Black", "Orange", "Silver"],
      availableStorage: ["Default"],
      specs: [
        "Always-On Retina Display",
        "Up to 36-hour Battery Life",
      ],
    ),
    Product(
      id: "iphone_15_pro",
      name: "iPhone 15 Pro",
      brand: "Apple",
      price: 999.99,
      originalPrice: 1099.99,
      imagePath: "assets/images/iPhone15Pro.png",
      rating: 4.8,
      reviewsCount: "1.8k",
      availableColors: [
        "Natural Titanium",
        "Blue Titanium",
        "White Titanium",
        "Black Titanium",
      ],
      availableStorage: ["128 GB", "256 GB", "512 GB", "1 TB"],
      specs: ["Super Retina XDR Display", "A17 Pro chip", "USB-C support"],
    ),
  ];

  // Helper method to add an item
  void addToCart(
    Product product,
    String color,
    String storage, {
    int quantity = 1,
  }) {
    final list = List<CartItem>.from(value);

    // Check if item already exists with same options
    final index = list.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedColor == color &&
          item.selectedStorage == storage,
    );

    if (index >= 0) {
      list[index].quantity += quantity;
    } else {
      list.add(
        CartItem(
          product: product,
          selectedColor: color,
          selectedStorage: storage,
          quantity: quantity,
        ),
      );
    }
    value = list;
  }

  // Helper method to update quantity
  void updateQuantity(CartItem item, int delta) {
    final list = List<CartItem>.from(value);
    final index = list.indexOf(item);
    if (index >= 0) {
      final newQty = list[index].quantity + delta;
      if (newQty <= 0) {
        list.removeAt(index);
      } else {
        list[index].quantity = newQty;
      }
      value = list;
    }
  }

  // Remove a specific item
  void removeFromCart(CartItem item) {
    final list = List<CartItem>.from(value);
    list.remove(item);
    value = list;
  }

  // Getters for totals
  double get subtotal {
    return value.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  double get shippingAndTax {
    return value.isEmpty
        ? 0.0
        : 15.00; // Hardcoded static shipping fee matching the mockup
  }

  double get total {
    return subtotal + shippingAndTax;
  }

  int get totalItems {
    return value.fold(0, (sum, item) => sum + item.quantity);
  }
}
