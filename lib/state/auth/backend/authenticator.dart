import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../posts/typedefs/user_id.dart';
import '../constants/constants.dart';
import '../models/auth_result.dart';

class Authenticator {
  final _firebaseAuth = FirebaseAuth.instance;
  User? get user => _firebaseAuth.currentUser;
  UserId? get userId => user?.uid;
  bool get isLoggedIn => user != null;
  String? get email => user?.email;
  String? get displayName => user?.displayName;

  Future<AuthResult> loginWithGoogle() async {
    final googleSignIn = GoogleSignIn(scopes: [Constants.emailScope]);

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return AuthResult.aborted;

    final googleAuth = await googleUser.authentication;
    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      return AuthResult.aborted;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _firebaseAuth.signInWithCredential(credential);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) return AuthResult.aborted;

    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      await _firebaseAuth.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers = await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          _firebaseAuth.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
