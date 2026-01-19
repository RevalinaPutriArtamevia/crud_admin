import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/food.dart';

class AppState extends ChangeNotifier {
  // AUTHENTICATION DATA 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  //  PRIVATE DATA 
  final List<String> _favoriteIds = [];
  final Map<String, int> _cart = {}; 
  String _selectedCategory = 'All';
  String _searchQuery = ''; 

  // CONSTRUCTOR 
  AppState() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // GETTERS 
  User? get user => _user; 
  bool get isLoggedIn => _user != null;
  List<String> get favorites => List.unmodifiable(_favoriteIds);
  Map<String, int> get cart => Map.unmodifiable(_cart);
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  //AUTHENTICATION METHODS 
  
  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found': return "Email tidak terdaftar.";
        case 'wrong-password': return "Password salah.";
        case 'user-disabled': return "Akun ini telah dinonaktifkan.";
        case 'invalid-email': return "Format email salah.";
        default: return e.message ?? "Terjadi kesalahan login.";
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use': return "Email sudah terdaftar.";
        case 'weak-password': return "Password terlalu lemah.";
        default: return e.message ?? "Gagal mendaftar.";
      }
    } catch (e) {
      return "Terjadi kesalahan: ${e.toString()}";
    }
  }

  // Reset Password via Firebase
  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found': return "Email tidak terdaftar.";
        case 'invalid-email': return "Format email tidak valid.";
        default: return e.message ?? "Gagal mengirim email reset.";
      }
    } catch (e) {
      return "Kesalahan: ${e.toString()}";
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _cart.clear(); 
    _favoriteIds.clear();
    _searchQuery = '';
    notifyListeners();
  }

  // SEARCH, FAVORITES, & CART METHODS (TIDAK BERUBAH) 
  void setSearchQuery(String query) { _searchQuery = query; notifyListeners(); }
  void setCategory(String category) { if (_selectedCategory != category) { _selectedCategory = category; notifyListeners(); } }
  void toggleFavorite(String id) { if (_favoriteIds.contains(id)) { _favoriteIds.remove(id); } else { _favoriteIds.add(id); } notifyListeners(); }
  bool isFavorite(String id) => _favoriteIds.contains(id);
  void addToCart(String id) { _cart.update(id, (q) => q + 1, ifAbsent: () => 1); notifyListeners(); }
  void removeFromCart(String id) { if (_cart.containsKey(id)) { if (_cart[id]! > 1) { _cart[id] = _cart[id]! - 1; } else { _cart.remove(id); } notifyListeners(); } }
  void clearCart() { _cart.clear(); notifyListeners(); }

  double cartTotal(List<Food> allFoods) {
    if (allFoods.isEmpty) return 0;
    double total = 0;
    for (final entry in _cart.entries) {
      try {
        final food = allFoods.firstWhere((f) => f.id == entry.key);
        total += food.price * entry.value;
      } catch (e) {}
    }
    return total;
  }
}