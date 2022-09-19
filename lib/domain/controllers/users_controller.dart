import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/query_executor.dart';
import '../models/notifier_state.dart';
import '../models/user.dart';

class UserState {
  final User? user;
  final NotifierState currentState;

  UserState({this.user, this.currentState = NotifierState.initial});

  UserState copyWith({
    User? user,
    NotifierState? currentState,
  }) {
    return UserState(
      user: user ?? this.user,
      currentState: currentState ?? this.currentState,
    );
  }
}

class UsersController extends StateNotifier<UserState> {
  final QueryExecutor queryExecutor;
  UsersController(this.queryExecutor) : super(UserState());

  void initGuestUser() {
    state = state.copyWith(user: User.empty());
  }

  void setName(String? value) {
    state = state.copyWith(user: state.user!.copyWith(name: value));
  }

  void setEmail(String? value) {
    state = state.copyWith(user: state.user!.copyWith(email: value));
  }

  void setPassword(String? value) {
    state = state.copyWith(user: state.user!.copyWith(password: value));
  }

  void setPhone(String? value) {
    state = state.copyWith(user: state.user!.copyWith(phone: value));
  }

  void setPhoto(String filePath) {
    /*  final Uint8List bytes = await file.readAsBytes();
    final imageStr = base64.encode(bytes); */
    state = state.copyWith(user: state.user!.copyWith(image: filePath));
  }

  Future<bool> insertUser() async {
    debugPrint(state.toString());

    final user = User(
      name: state.user!.name.trim(),
      email: state.user!.email.trim(),
      phone: state.user!.phone.trim(),
      password: state.user!.password.trim(),
      image: state.user!.image.trim(),
    );

    debugPrint('inseted user details: ${user.toString()}');

    final insertedId = await queryExecutor.insertUser(user);

    debugPrint('insertedId: $insertedId');

    return insertedId > 0;
  }

  Future<bool> logout() async {
    final result = await queryExecutor.logout(state.user!);
    state = state.copyWith(user: null);
    return result;
  }
}
