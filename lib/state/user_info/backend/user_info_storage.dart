import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instant_gram/state/constants/firestore_field_names.dart';
import 'package:instant_gram/state/user_info/models/user_info_payload.dart';

import '../../constants/firestore_collection_names.dart';

@immutable
class UserInfoStorage {
  UserInfoStorage();

  final usersRef =
      FirebaseFirestore.instance.collection(FirestoreCollectionNames.users);

  Future<bool> saveUserInfo({
    required String uid,
    required String? email,
    required String displayName,
  }) async {
    try {
      final userInfo = await usersRef.doc(uid).get();

      if (userInfo.exists) {
        /// [Update] the [existing user] info.
        await userInfo.reference.update({
          FirestoreFieldNames.email: email,
          FirestoreFieldNames.displayName: displayName,
        });
      }

      /// Save as [new user].
      final payload = UserInfoPayload(email: email, displayName: displayName);
      await usersRef.doc(uid).set(payload);

      return true;
    } catch (e) {
      return false;
    }
  }
}
