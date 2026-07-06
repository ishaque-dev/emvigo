class UserProfileEntity {
  final String uid;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final Gender gender;
  final String nationality;
  final List<String> languages;
  const UserProfileEntity({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.languages,
  });
}

enum Gender { male, female }
