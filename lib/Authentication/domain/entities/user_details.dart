import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? image;
  bool? is_manager;
  bool? mark;
  int? managerId;
  String? placeType;
  String? model1Input;

  UserDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.image,
    this.is_manager,
    this.mark,
    this.managerId,
    this.placeType,
    this.model1Input,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    id != null ? data['id'] = id : null;
    email != null ? data['email'] = email : null;
    username != null ? data['username'] = username : null;

    // data['firstName'] = firstName;
    // data['lastName'] = lastName;
    image != null ? data['image'] = image : null;
    placeType != null ? data['placeType'] = placeType : null;
    model1Input != null ? data['model1Input'] = model1Input : null;
    return data;
  }

  @override
  List<Object> get props {
    return [];
  }
}
