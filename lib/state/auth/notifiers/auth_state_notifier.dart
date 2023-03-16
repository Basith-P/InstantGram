import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instant_gram/state/posts/typedefs/user_id.dart';

import '../../user_info/backend/user_info_storage.dart';
import '../backend/authenticator.dart';
import '../models/auth_result.dart';
import '../models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  static const _authenticator = Authenticator();

  final _userInfoStorage = UserInfoStorage();

  AuthStateNotifier() : super(AuthState.unknown()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
        authResult: AuthResult.success,
        userId: _authenticator.userId,
        isLoading: false,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true);
    final authResult = await _authenticator.loginWithGoogle();
    if (authResult == AuthResult.success && _authenticator.userId != null) {
      await saveUserInfo(_authenticator.userId!);
      state = AuthState(
          authResult: authResult,
          userId: _authenticator.userId,
          isLoading: false);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWith(isLoading: true);
    final authResult = await _authenticator.loginWithFacebook();
    if (authResult == AuthResult.success && _authenticator.userId != null) {
      await saveUserInfo(_authenticator.userId!);
      state = AuthState(
          authResult: authResult,
          userId: _authenticator.userId,
          isLoading: false);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> saveUserInfo(UserId userId) async =>
      await _userInfoStorage.saveUserInfo(
          uid: userId,
          email: _authenticator.email,
          displayName: _authenticator.displayName ?? '');

  Future<void> logOut() async {
    state = state.copyWith(isLoading: true);
    await _authenticator.logOut();
    state = AuthState.unknown();
  }
}
