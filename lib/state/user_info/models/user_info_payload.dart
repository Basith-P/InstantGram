import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firestore_field_names.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required String? email,
    required String displayName,
  }) : super({
          FirestoreFieldNames.email: email ?? '',
          FirestoreFieldNames.displayName: displayName,
        });
}
