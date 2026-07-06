import 'package:emvigo/core/error/failure.dart';
import 'package:emvigo/core/error/network_exceptions.dart';
import 'package:emvigo/features/sign_up/data/data_sources/i_sign_up_remote_ds.dart';
import 'package:emvigo/features/sign_up/domain/repositories/i_sign_up_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class SignUpRepoImpl implements ISignUpRepo {
  final ISignUpRemoteDs _signUpRemoteDs;
  SignUpRepoImpl({required this._signUpRemoteDs});
  @override
  Future<Either<Failure, UserCredential>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _signUpRemoteDs.signUp(
        email: email,
        password: password,
      );
      return right(userCredential);
    } catch (e) {
      return left(GenericFailure(e.toString()));
    }
  }
}
