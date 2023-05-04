import '../../domain/entities/user_details.dart';

class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {required int id,
      required String email,
      required String firstName,
      required String lastName,
      required String username})
      : super(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            username: username);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
          id: json['id'],
          email: json['email'],
          firstName: json['first_name'],
          lastName: json['last_name'],
          username: json['username']);
}
