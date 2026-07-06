import 'package:emvigo/core/error/failure.dart';
import 'package:emvigo/core/usecase/use_case.dart';
import 'package:emvigo/features/create_profile/domain/entities/user_profile_entity.dart';
import 'package:emvigo/features/create_profile/domain/repositories/i_user_profile_repo.dart';
import 'package:fpdart/fpdart.dart';

class CreateProfileUseCase implements UseCase<bool, UserProfileEntity> {
  IUserProfileRepo userProfileRepo;
  CreateProfileUseCase({required this.userProfileRepo});

  @override
  Future<Either<Failure, bool>> call({
    required UserProfileEntity parameters,
  }) async {
    final result = await userProfileRepo.createUserProfile(parameters);
    return result.fold((failure) => left(failure), (unit) => right(true));
  }
}
