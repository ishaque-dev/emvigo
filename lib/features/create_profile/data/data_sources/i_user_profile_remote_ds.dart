import 'package:emvigo/features/create_profile/data/model/user_profile_model.dart';

abstract interface class IUserProfileRemoteDs {
  Future<UserProfileModel> getUserProfile(String uid);
  Future<void> createUserProfile(UserProfileModel userProfile);
}
