part of 'obscure_bloc.dart';

abstract class ObscureState {
  ObscureState();
  bool isObscure = true;
}

class IsObscureInitial extends ObscureState {}

class IsObscureState extends ObscureState {
  bool isObscure = true;
  IsObscureState({
    required this.isObscure,
  });
}
