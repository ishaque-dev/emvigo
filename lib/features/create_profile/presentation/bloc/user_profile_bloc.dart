import 'package:bloc/bloc.dart';
import 'package:emvigo/features/create_profile/domain/entities/user_profile_entity.dart';
import 'package:emvigo/features/create_profile/domain/use_cases/create_profile_use_case.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  CreateProfileUseCase createUserProfileUseCase;
  UserProfileBloc({required this.createUserProfileUseCase})
    : super(UserProfileInitial()) {
    on<CreateUserProfile>((event, emit) async {
      emit(UserProfileLoading());
      final result = await createUserProfileUseCase(
        parameters: event.userProfile,
      );
      result.fold(
        (failure) => emit(UserProfileFailure(errorMessage: failure.message)),
        (success) => emit(UserProfileSuccess()),
      );
    });
  }
}
