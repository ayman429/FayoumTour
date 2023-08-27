import 'package:equatable/equatable.dart';

class RateOneByOne extends Equatable {
  final int i1;
  final int i2;
  final int i3;
  final int i4;
  final int i5;

  const RateOneByOne(
      {required this.i1,
      required this.i2,
      required this.i3,
      required this.i4,
      required this.i5});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = i1;
    data['2'] = i2;
    data['3'] = i3;
    data['4'] = i4;
    data['5'] = i5;
    return data;
  }

  @override
  List<Object> get props {
    return [
      i1,
      i2,
      i3,
      i4,
      i5,
    ];
  }
}
