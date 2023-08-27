// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ChangePassword extends Equatable {
  final String new_password1;
  final String new_password2;
  const ChangePassword({
    required this.new_password1,
    required this.new_password2,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['new_password1'] = new_password1;
    data['new_password2'] = new_password2;
    return data;
  }

  @override
  List<Object> get props => [new_password1, new_password2];
}
