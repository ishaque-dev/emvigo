import 'package:bloc/bloc.dart';
import 'package:emvigo/features/sign_in/domain/entities/sign_in_request_entity.dart';
import 'package:emvigo/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  SignInBloc({required this.signInUseCase}) : super(SignInInitial()) {
    on<SignIn>((event, emit) async {
      emit(SignInLoading());
      final result = await signInUseCase(parameters: event.signInRequestEntity);
      result.fold(
        (failure) => emit(SignInFailure(errorMessage: failure.message)),
        (userCredential) => emit(SignInSuccess(userCredential: userCredential)),
      );
    });
  }
}
