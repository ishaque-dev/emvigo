import 'package:emvigo/features/sign_in/data/data_sources/i_sign_in_remote_ds.dart';
import 'package:emvigo/features/sign_in/data/models/sign_in_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInRemoteDsImpl implements ISignInRemoteDs {
  final FirebaseAuth _firebaseAuth;
  SignInRemoteDsImpl({required this._firebaseAuth});

  @override
  Future<UserCredential> signIn({
    required SignInRequestModel signInRequestModel,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: signInRequestModel.email,
        password: signInRequestModel.password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
