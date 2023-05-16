import '../../domain/entities/user_details.dart';

class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {required String email,
      required String firstName,
      required String lastName,
      required String username})
      : super(
            email: email,
            firstName: firstName,
            lastName: lastName,
            username: username);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
          email: json['email'],
          firstName: json['first_name'],
          lastName: json['last_name'],
          username: json['username']);

  UserDetailsModel.castFromEntity(final UserDetails userDetails)
      : super(
            email: userDetails.email,
            username: userDetails.username,
            firstName: userDetails.firstName,
            lastName: userDetails.lastName);
}
