import 'package:emvigo/core/error/failure.dart' show Failure;
import 'package:emvigo/features/sign_in/domain/entities/sign_in_request_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISignInRepo {
  Future<Either<Failure, UserCredential>> signIn({
    required SignInRequestEntity signInInfo,
  });
}
