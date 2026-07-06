import 'package:emvigo/core/error/failure.dart';
import 'package:emvigo/core/error/network_exceptions.dart';
import 'package:emvigo/features/create_profile/data/data_sources/i_user_profile_remote_ds.dart';
import 'package:emvigo/features/create_profile/data/model/user_profile_model.dart';
import 'package:emvigo/features/create_profile/domain/entities/user_profile_entity.dart';
import 'package:emvigo/features/create_profile/domain/repositories/i_user_profile_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserProfileRepoImpl implements IUserProfileRepo {
  IUserProfileRemoteDs userProfileRemoteDs;
  UserProfileRepoImpl(this.userProfileRemoteDs);

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile(String uid) async {
    try {
      final userProfileModel = await userProfileRemoteDs.getUserProfile(uid);
      return right(userProfileModel.toEntity());
    } catch (e) {
      return left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserProfile(
    UserProfileEntity userProfile,
  ) async {
    try {
      await userProfileRemoteDs.createUserProfile(
        UserProfileModel.fromEntity(userProfile),
      );
      return right(unit);
    } catch (e) {
      return left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUserProfile(
    UserProfileEntity userProfile,
  ) async {
    try {
      await userProfileRemoteDs.createUserProfile(
        UserProfileModel.fromEntity(userProfile),
      );
      return right(unit);
    } catch (e) {
      return left(GenericFailure(e.toString()));
    }
  }
}
