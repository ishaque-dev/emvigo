import 'package:emvigo/features/sign_in/domain/entities/sign_in_request_entity.dart';

class SignInRequestModel {
  final String email;
  final String password;

  SignInRequestModel({required this.email, required this.password});

  factory SignInRequestModel.fromEntity(SignInRequestEntity entity) {
    return SignInRequestModel(email: entity.email, password: entity.password);
  }
}
