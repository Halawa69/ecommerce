import 'package:ecommerce/features/auth/domain/usecase/insrtUser.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecase/checkUser.dart';
import '../../domain/usecase/checkUserLogin.dart';

class UserProvider extends ChangeNotifier {
  final CheckUser checkUserUseCase;
  final CheckUserLogin checkUserLoginUseCase;
  final InsertUser insertUserUseCase;

  UserProvider({
    required this.checkUserUseCase,
    required this.checkUserLoginUseCase,
    required this.insertUserUseCase,
  });

  String _username = '';
  String _email = '';
  String _address = '';
  String _password = '';
  String _confirmPassword = '';
  String _phone = '';

  // Getters
  String get username => _username;
  String get email => _email;
  String get address => _address;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get phone => _phone;

  // Setters
  void setUsername(String value) { _username = value; notifyListeners(); }
  void setEmail(String value) { _email = value; notifyListeners(); }
  void setAddress(String value) { _address = value; notifyListeners(); }
  void setPassword(String value) { _password = value; notifyListeners(); }
  void setConfirmPassword(String value) { _confirmPassword = value; notifyListeners(); }
  void setPhone(String value) { _phone = value; notifyListeners(); }

  // Validation functions
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return "Username is required";
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) return "Invalid email format";
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) return "Address is required";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return "Confirm password is required";
    if (value != _password) return "Passwords do not match";
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Phone number is required";
    if (!RegExp(r"^\d{10,}$").hasMatch(value)) return "Invalid phone number";
    return null;
  }

  // SignUp function
  Future<String?> signUp() async {
    // تحقق إذا المستخدم موجود
    final existingUser = await checkUserUseCase.call(_email, _username);
    if (existingUser != null) {
      return "User already exists";
    }

    // إنشاء المستخدم الجديد
    final user = User(
      username: _username,
      email: _email,
      address: _address,
      password: _password,
      number: _phone,
      token: '', // توليد التوكن لو محتاج
    );

    // إدخال المستخدم
    return await insertUserUseCase.call(user);
  }

  // Login function
  Future<User?> login(String email, String password) async {
    return await checkUserLoginUseCase.call(email, password);
  }
}
