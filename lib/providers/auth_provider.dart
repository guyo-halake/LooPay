import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/database_helper.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  UserModel? _currentUser;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _initialized = false;

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _currentUser?.name;
  String? get userEmail => _currentUser?.email;
  String? get userPhone => _currentUser?.phone;
  double get walletBalance => _currentUser?.balance ?? 0.0;
  bool get isKycVerified => _currentUser?.isKycVerified ?? false;
  UserModel? get currentUser => _currentUser;

  // Initialize auth state
  Future<void> initializeAuth() async {
    if (_initialized) return;
    _initialized = true;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId != null) {
      final userData = await _dbHelper.getUserById(userId);
      if (userData != null) {
        _currentUser = UserModel.fromMap(userData);
        _isLoggedIn = true;
        notifyListeners();
      }
    }
  }

  // Login method with phone and PIN
  Future<bool> login(String phone, String pin) async {
    try {
      // Clean phone number
      final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');

      // Authenticate user
      final isAuthenticated = await _dbHelper.authenticateUser(cleanPhone, pin);

      if (isAuthenticated) {
        final userData = await _dbHelper.getUserByPhone(cleanPhone);
        if (userData != null) {
          _currentUser = UserModel.fromMap(userData);
          _isLoggedIn = true;

          // Save user session
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', _currentUser!.id!);

          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Signup method
  Future<bool> signup(
      String name, String email, String phone, String pin) async {
    try {
      // Clean phone number
      final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');

      // Check if user already exists
      final userExists = await _dbHelper.userExists(cleanPhone);
      if (userExists) {
        return false; // User already exists
      }

      // Create new user
      final now = DateTime.now();
      final userData = {
        'name': name,
        'email': email.isNotEmpty ? email : null,
        'phone': cleanPhone,
        'pin': pin,
        'balance': 0.0,
        'is_kyc_verified': 0,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final userId = await _dbHelper.insertUser(userData);

      if (userId > 0) {
        // Get the created user
        final user = await _dbHelper.getUserById(userId);
        if (user != null) {
          _currentUser = UserModel.fromMap(user);
          _isLoggedIn = true;

          // Save user session
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', userId);

          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    _isLoggedIn = false;
    _currentUser = null;

    // Clear user session
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');

    notifyListeners();
  }

  // Update wallet balance
  Future<void> updateWalletBalance(double amount) async {
    if (_currentUser != null) {
      await _dbHelper.updateUserBalance(_currentUser!.id!, amount);
      _currentUser = _currentUser!.copyWith(balance: amount);
      notifyListeners();
    }
  }

  // Verify KYC
  Future<void> verifyKyc() async {
    if (_currentUser != null) {
      await _dbHelper.updateUserKyc(_currentUser!.id!, true);
      _currentUser = _currentUser!.copyWith(isKycVerified: true);
      notifyListeners();
    }
  }

  // Add sample transaction
  Future<void> addTransaction({
    required String type,
    required String recipient,
    required double amount,
    String currency = 'KES',
  }) async {
    if (_currentUser != null) {
      final transaction = {
        'user_id': _currentUser!.id,
        'type': type,
        'recipient': recipient,
        'amount': amount,
        'currency': currency,
        'status': 'completed',
        'date': DateTime.now().toIso8601String(),
      };

      await _dbHelper.insertTransaction(transaction);

      // Update balance
      final newBalance = _currentUser!.balance - amount;
      await updateWalletBalance(newBalance);
    }
  }

  // Get user transactions
  Future<List<Map<String, dynamic>>> getUserTransactions() async {
    if (_currentUser != null) {
      return await _dbHelper.getUserTransactions(_currentUser!.id!);
    }
    return [];
  }
}
