import 'package:emvigo/core/error/failure.dart';
import 'package:emvigo/core/error/network_exceptions.dart';
import 'package:emvigo/features/sign_in/data/data_sources/i_sign_in_remote_ds.dart';
import 'package:emvigo/features/sign_in/data/models/sign_in_model.dart';
import 'package:emvigo/features/sign_in/domain/entities/sign_in_request_entity.dart';
import 'package:emvigo/features/sign_in/domain/repositories/I_sign_in_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class SignInRepoImpl implements ISignInRepo {
  final ISignInRemoteDs _signInRemoteDs;

  SignInRepoImpl({required this._signInRemoteDs});

  @override
  Future<Either<Failure, UserCredential>> signIn({
    required SignInRequestEntity signInInfo,
  }) async {
    try {
      final userCredential = await _signInRemoteDs.signIn(
        signInRequestModel: SignInRequestModel.fromEntity(signInInfo),
      );
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return left(GenericFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      return left(GenericFailure(e.toString()));
    }
  }
}
