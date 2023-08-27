import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String email;
  final String password;
  const Login({
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
