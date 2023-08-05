import '../../domain/entities/created_by.dart';

class CreatedByModel extends CreatedBy {
  CreatedByModel(
      {required super.id,
      required super.userName,
      required super.email,
      required super.image,
      required super.mark});

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      image: json['image'],
      mark: json['mark']);
}
