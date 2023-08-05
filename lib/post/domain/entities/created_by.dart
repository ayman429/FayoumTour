class CreatedBy {
  int? id;
  String? userName;
  String? email;
  var image;
  bool? mark;
  CreatedBy({this.id, this.userName, this.email, this.image, this.mark});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['image'] = image;
    data['mark'] = mark;
    return data;
  }
}
