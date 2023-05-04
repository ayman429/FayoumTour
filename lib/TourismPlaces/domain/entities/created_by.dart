class CreatedBy {
  int? id;
  String? userName;
  String? email;

  CreatedBy({this.id, this.userName, this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    return data;
  }
}
