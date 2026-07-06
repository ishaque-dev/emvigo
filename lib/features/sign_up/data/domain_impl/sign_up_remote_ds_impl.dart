import 'package:emvigo/features/sign_up/data/data_sources/i_sign_up_remote_ds.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRemoteDsImpl implements ISignUpRemoteDs {
  final FirebaseAuth _firebaseAuth;
  SignUpRemoteDsImpl({required this._firebaseAuth});
  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Pass the error code so it can be handled in the bloc
      throw Exception('${e.code}:${e.message}');
    }
  }
}
