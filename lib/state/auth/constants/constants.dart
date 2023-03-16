import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  const Constants._();

  static const accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const emailAlreadyInUse = 'email-already-in-use';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
}
