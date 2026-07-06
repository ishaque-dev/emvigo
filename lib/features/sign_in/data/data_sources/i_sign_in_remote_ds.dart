import 'package:emvigo/features/sign_in/data/models/sign_in_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class ISignInRemoteDs {
  Future<UserCredential> signIn({
    required SignInRequestModel signInRequestModel,
  });
}
