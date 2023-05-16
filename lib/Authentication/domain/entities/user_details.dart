import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  String email;
  String firstName;
  String lastName;
  String username;

  UserDetails(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.username});

  @override
  List<Object> get props {
    return [
      email,
      firstName,
      lastName,
      username,
    ];
  }
}
