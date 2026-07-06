import 'package:emvigo/core/error/failure.dart';
import 'package:emvigo/features/create_profile/domain/entities/user_profile_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IUserProfileRepo {
  Future<Either<Failure, UserProfileEntity>> getUserProfile(String uid);
  Future<Either<Failure, Unit>> createUserProfile(
    UserProfileEntity userProfile,
  );
  Future<Either<Failure, Unit>> updateUserProfile(
    UserProfileEntity userProfile,
  );
}
