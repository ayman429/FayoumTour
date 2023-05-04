import 'package:equatable/equatable.dart';

class PasswordResetConfirm extends Equatable {
  String new_password1;
  String new_password2;
  String link;
  PasswordResetConfirm({
    required this.new_password1,
    required this.new_password2,
    required this.link,
  });

  Map<String, dynamic> toJson() {
    // int uid;
    // uid = int.parse(link.substring(link.length - 42, link.length - 41));
    Map<String, dynamic> data = <String, dynamic>{};
    data['new_password1'] = new_password1;
    data['new_password2'] = new_password2;
    data['uid'] = link.substring(link.length - 42, link.length - 41);
    data['token'] = link.substring(link.length - 40, link.length - 1);
    return data;
  }

  @override
  List<Object> get props => [new_password1, new_password2, link];
}

// 39 
// -1 --> /
// -2 : -40
// -42 --> uid