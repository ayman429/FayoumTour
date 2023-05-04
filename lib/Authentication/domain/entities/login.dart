import 'package:equatable/equatable.dart';

class Login extends Equatable {
  String email;
  String password;
  Login({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  List<Object> get props => [email, password];
}
