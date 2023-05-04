import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  int id;
  String email;
  String firstName;
  String lastName;
  String username;

  UserDetails(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.username});

  @override
  List<Object> get props {
    return [
      id,
      email,
      firstName,
      lastName,
      username,
    ];
  }
}
