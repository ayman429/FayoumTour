class ErrorMassageModel {
  // final int statusCode;
  dynamic statusMassage;

  ErrorMassageModel({
    // required this.statusCode,
    required this.statusMassage,
  });

  factory ErrorMassageModel.fromJson(dynamic json) {
    return ErrorMassageModel(statusMassage: json);
  }
}
