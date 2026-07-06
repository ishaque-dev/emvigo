import 'package:bloc/bloc.dart';
import 'package:emvigo/features/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:emvigo/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpUseCase signUpUseCase;
  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<SignUp>((event, emit) async {
      emit(SignUpLoading());

      final result = await signUpUseCase.call(
        parameters: SignUpCredentialEntity(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          String errorMessage = failure.toString();

          // Handle specific Firebase errors
          if (errorMessage.contains('email-already-in-use')) {
            errorMessage =
                'This email is already registered. Please try signing in.';
          } else if (errorMessage.contains('weak-password')) {
            errorMessage =
                'Password is too weak. Please use a stronger password.';
          } else if (errorMessage.contains('invalid-email')) {
            errorMessage = 'Invalid email address. Please check and try again.';
          } else if (errorMessage.contains('operation-not-allowed')) {
            errorMessage =
                'Sign up is currently disabled. Please try again later.';
          }

          emit(SignUpFailure(errorMessage: errorMessage));
        },
        (userCredential) => emit(
          SignUpSuccess(
            message: 'Account created successfully!',
            uid: userCredential.user?.uid ?? '',
          ),
        ),
      );
    });
  }
}
