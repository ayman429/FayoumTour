import '../../domain/entities/user_details.dart';

class UserDetailsModel extends UserDetails {
  UserDetailsModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String username,
    required String image,
    required bool is_manager,
    required int managerId,
  }) : super(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            username: username,
            image: image,
            is_manager: is_manager,
            managerId: managerId);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        id: json['id'].toString(),
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        image: json['image'] ?? "",
        is_manager: json['is_manager'],
        managerId: json['managerId'],
      );

  UserDetailsModel.castFromEntity(final UserDetails userDetails)
      : super(
          id: userDetails.id,
          email: userDetails.email,
          username: userDetails.username,
          firstName: userDetails.firstName,
          lastName: userDetails.lastName,
          image: userDetails.image,
        );
}
