import 'package:equatable/equatable.dart';

class Registration extends Equatable {
  String username;
  String email;
  String password1;
  String password2;

  Registration(
      {required this.username,
      required this.email,
      required this.password1,
      required this.password2});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password1'] = password1;
    data['password2'] = password2;
    return data;
  }

  @override
  List<Object> get props => [username, email, password1, password2];
}
