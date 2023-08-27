import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final String email;
  const ResetPassword({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }

  @override
  List<Object> get props => [email];
}
