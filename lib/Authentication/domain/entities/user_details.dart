import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  String id;
  String email;
  String firstName;
  String lastName;
  String username;
  String? image;
  bool? is_manager;
  int? managerId;

  UserDetails({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.image,
    this.is_manager,
    this.managerId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['image'] = image;
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
