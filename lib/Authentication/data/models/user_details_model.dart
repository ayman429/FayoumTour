import '../../domain/entities/user_details.dart';

class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {required String id,
      required String email,
      required String firstName,
      required String lastName,
      required String username,
      required String image,
      required bool is_manager,
      required int managerId,
      required String placeType,
      required String model1Input})
      : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          username: username,
          image: image,
          is_manager: is_manager,
          managerId: managerId,
          placeType: placeType,
          model1Input: model1Input,
        );

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
        placeType: json['placeType'],
        model1Input: json['model1Input'],
      );

  UserDetailsModel.castFromEntity(final UserDetails userDetails)
      : super(
          id: userDetails.id,
          email: userDetails.email,
          username: userDetails.username,
          firstName: userDetails.firstName,
          lastName: userDetails.lastName,
          image: userDetails.image,
          placeType: userDetails.placeType,
          model1Input: userDetails.model1Input,
        );
}
