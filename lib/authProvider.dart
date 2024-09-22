import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();  // Notify listeners to update UI
  }

  void clearToken() {
    _token = null;
    notifyListeners();
  }

  bool get isSignedIn => _token != null;
}
