import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emvigo/features/create_profile/data/data_sources/i_user_profile_remote_ds.dart';
import 'package:emvigo/features/create_profile/data/model/user_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileRemoteDsImpl implements IUserProfileRemoteDs {
  FirebaseFirestore firestore;
  FirebaseAuth firebaseAuth;
  UserProfileRemoteDsImpl({
    required this.firestore,
    required this.firebaseAuth,
  });
  @override
  Future<UserProfileModel> getUserProfile(String uid) {
    try {
      return firestore.collection('userProfiles').doc(uid).get().then((doc) {
        if (doc.exists) {
          return UserProfileModel.fromJson(doc.data()!);
        } else {
          throw Exception('User profile not found');
        }
      });
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  @override
  Future<void> createUserProfile(UserProfileModel userProfile) async {
    String? uid = firebaseAuth.currentUser?.uid;
    UserProfileModel userProfileWithUid = userProfile.copyWith(uid: uid ?? '');
    try {
      return await firestore
          .collection('userProfiles')
          .doc(userProfileWithUid.uid)
          .set(userProfileWithUid.toJson());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }
}
