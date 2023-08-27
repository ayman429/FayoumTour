import '../../domain/entities/rate_one_by_one.dart';

class RateOneByOneModel extends RateOneByOne {
  const RateOneByOneModel(
      {required super.i1,
      required super.i2,
      required super.i3,
      required super.i4,
      required super.i5});

  factory RateOneByOneModel.fromJson(Map<String, dynamic> json) =>
      RateOneByOneModel(
        i1: json['1'],
        i2: json['2'],
        i3: json['3'],
        i4: json['4'],
        i5: json['5'],
      );
}
