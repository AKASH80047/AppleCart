import 'package:flutter/material.dart';
import '../models/products.dart';

class WishlistManager {
  // Singleton pattern
  static final WishlistManager _instance = WishlistManager._internal();
  factory WishlistManager() => _instance;

  final ValueNotifier<Set<String>> _favoritesNotifier = ValueNotifier<Set<String>>({});

  ValueNotifier<Set<String>> get favoritesNotifier => _favoritesNotifier;

  Set<String> get favoriteIds => _favoritesNotifier.value;

  WishlistManager._internal() {
    // Initialize favorites based on initial product list states
    final initialFavs = products.where((p) => p.isFavorite).map((p) => p.id).toSet();
    _favoritesNotifier.value = initialFavs;
  }

  bool isFavorite(String productId) {
    return _favoritesNotifier.value.contains(productId);
  }

  void toggleFavorite(String productId) {
    final current = Set<String>.from(_favoritesNotifier.value);
    if (current.contains(productId)) {
      current.remove(productId);
    } else {
      current.add(productId);
    }
    _favoritesNotifier.value = current;
  }
}
