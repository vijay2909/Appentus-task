import 'package:flutter/foundation.dart';

import '../../data/database/query_executor.dart';
import '../models/user.dart';

class LoginController with ChangeNotifier {
  final QueryExecutor queryExecutor;
  LoginController(this.queryExecutor);

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  Future<User?> getUser() async {
    return await queryExecutor.getLoggedInUser();
  }

  void setEmail(String? value) {
    _email = value!;
  }

  void setPassword(String? value) {
    _password = value!;
  }

  Future<bool> login() async {
    final exists = await queryExecutor.login(
      email: email.trim(),
      password: password.trim(),
    );

    return exists;
  }
}
