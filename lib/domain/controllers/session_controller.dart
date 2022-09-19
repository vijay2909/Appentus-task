import 'package:appentus_interview_task/data/database/query_executor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class SessionController extends StateNotifier<User?> {
  final QueryExecutor queryExecutor;
  SessionController(this.queryExecutor) : super(null);

  void isUserLoggedIn() async {
    state = await queryExecutor.getLoggedInUser();
    debugPrint("isUserLoggedIn user: ${state.toString()}");
  }

  Future<bool> logout() async {
    if (state != null) {
      final result = await queryExecutor.logout(state!);
      if (result) {
        state = null;
      }
      return result;
    }
    return false;
  }
}
