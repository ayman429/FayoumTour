import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  String id;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }

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
