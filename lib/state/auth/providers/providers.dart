import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instant_gram/state/posts/typedefs/user_id.dart';

import '../models/auth_result.dart';
import '../models/auth_state.dart';
import '../notifiers/auth_state_notifier.dart';

final authStaeProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());

final isLoggedinProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStaeProvider);
  return authState.authResult == AuthResult.success;
});

final userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authStaeProvider).userId);
