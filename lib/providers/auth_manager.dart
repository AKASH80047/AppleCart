import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthManager extends ChangeNotifier {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;

  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;

  AuthManager._internal() {
    // Default logged in demo user
    _currentUser = UserModel(
      id: "user_001",
      name: "Akash Pandey",
      email: "akash@example.com",
      phone: "+91 98765 43210",
      occupation: "Flutter Developer",
    );
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulated network delay
    await Future.delayed(const Duration(milliseconds: 600));

    if (email.trim().isNotEmpty && password.trim().isNotEmpty) {
      // Determine name from email or default
      String name = email.split('@').first;
      if (name.isNotEmpty) {
        name = name[0].toUpperCase() + name.substring(1);
      } else {
        name = "Akash Pandey";
      }

      _currentUser = UserModel(
        id: "user_${DateTime.now().millisecondsSinceEpoch}",
        name: name,
        email: email.trim(),
        phone: "+91 98765 43210",
        occupation: "Customer",
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String phone = "",
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    if (name.trim().isNotEmpty && email.trim().isNotEmpty && password.trim().isNotEmpty) {
      _currentUser = UserModel(
        id: "user_${DateTime.now().millisecondsSinceEpoch}",
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim().isNotEmpty ? phone.trim() : "+91 98765 43210",
        occupation: "New Member",
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? occupation,
  }) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name,
        email: email,
        phone: phone,
        occupation: occupation,
      );
      notifyListeners();
    }
  }
}
