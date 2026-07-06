part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class CreateUserProfile extends UserProfileEvent {
  final UserProfileEntity userProfile;

  const CreateUserProfile({required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}
