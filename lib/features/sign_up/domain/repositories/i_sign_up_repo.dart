import 'package:emvigo/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ISignUpRepo {
  Future<Either<Failure, UserCredential>> signUp({
    required String email,
    required String password,
  });
}
