import 'package:emvigo/core/error/failure.dart';
import 'package:emvigo/core/usecase/use_case.dart';
import 'package:emvigo/features/sign_in/domain/entities/sign_in_request_entity.dart';
import 'package:emvigo/features/sign_in/domain/repositories/I_sign_in_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';

class SignInUseCase implements UseCase<UserCredential, SignInRequestEntity> {
  ISignInRepo signInRepo;
  SignInUseCase({required this.signInRepo});
  @override
  Future<Either<Failure, UserCredential>> call({
    required SignInRequestEntity parameters,
  }) async {
    return await signInRepo.signIn(signInInfo: parameters);
  }
}
