import 'package:emvigo/core/error/failure.dart';
import 'package:emvigo/core/error/network_exceptions.dart';
import 'package:emvigo/core/usecase/use_case.dart';
import 'package:emvigo/features/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:emvigo/features/sign_up/domain/repositories/i_sign_up_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';

class SignUpUseCase implements UseCase<UserCredential, SignUpCredentialEntity> {
  ISignUpRepo signUpRepo;
  SignUpUseCase({required this.signUpRepo});
  Future<UserCredential> execute({
    required String email,
    required String password,
  }) async {
    final result = await signUpRepo.signUp(email: email, password: password);
    return result.fold(
      (failure) => GenericFailure(failure.toString()) as UserCredential,
      (userCredential) => userCredential,
    );
  }

  @override
  Future<Either<Failure, UserCredential>> call({
    required SignUpCredentialEntity parameters,
  }) {
    return signUpRepo.signUp(
      email: parameters.email,
      password: parameters.password,
    );
  }
}
