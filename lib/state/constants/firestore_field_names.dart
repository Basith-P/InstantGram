import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirestoreFieldNames {
  static const uid = 'uid';
  static const email = 'email';
  static const displayName = 'display_name';
  static const postId = 'post_id';
  static const text = 'text';
  static const createdAt = 'created_at';

  const FirestoreFieldNames._();
}
