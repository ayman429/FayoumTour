part of 'obscure_bloc.dart';

abstract class ObscureEvent extends Equatable {
  const ObscureEvent();

  @override
  List<Object> get props => [];
}

class IsObscureEvent extends ObscureEvent {}
