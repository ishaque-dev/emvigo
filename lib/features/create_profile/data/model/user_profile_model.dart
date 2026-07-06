import 'package:emvigo/features/create_profile/domain/entities/user_profile_entity.dart';

class UserProfileModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String nationality;
  final List<String> languages;

  const UserProfileModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.languages,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      nationality: json['nationality'],
      languages: List<String>.from(json['languages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'nationality': nationality,
      'languages': languages,
    };
  }

  /// Domain -> Model
  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      uid: entity.uid,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dateOfBirth: entity.dateOfBirth.toIso8601String(),
      gender: entity.gender.name,
      nationality: entity.nationality,
      languages: entity.languages,
    );
  }

  /// Model -> Domain
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: DateTime.parse(dateOfBirth),
      gender: Gender.values.byName(gender),
      nationality: nationality,
      languages: languages,
    );
  }

  UserProfileModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? nationality,
    List<String>? languages,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      languages: languages ?? this.languages,
    );
  }
}
