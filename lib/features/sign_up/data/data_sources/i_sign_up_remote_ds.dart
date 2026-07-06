import 'package:firebase_auth/firebase_auth.dart';

abstract interface class ISignUpRemoteDs {
  Future<UserCredential> signUp({
    required String email,
    required String password,
  });
}
