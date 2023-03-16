import 'package:flutter/foundation.dart' show immutable;

import '../../posts/typedefs/user_id.dart';
import 'auth_result.dart';

@immutable
class AuthState {
  final AuthResult? authResult;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.authResult,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : authResult = null,
        isLoading = false,
        userId = null;

  AuthState copyWith({
    AuthResult? authResult,
    bool? isLoading,
    UserId? userId,
  }) {
    return AuthState(
      authResult: authResult ?? this.authResult,
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
    );
  }

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          authResult == other.authResult &&
          isLoading == other.isLoading &&
          userId == other.userId;

  @override
  int get hashCode =>
      authResult.hashCode ^ isLoading.hashCode ^ userId.hashCode;
}
