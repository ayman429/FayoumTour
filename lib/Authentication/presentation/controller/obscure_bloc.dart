import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'obscure_event.dart';
part 'obscure_state.dart';

class ObscureBloc extends Bloc<ObscureEvent, ObscureState> {
  bool isObscure = true;
  ObscureBloc() : super(IsObscureInitial()) {
    on<IsObscureEvent>((event, emit) {
      isObscure = !isObscure;
      emit(IsObscureState(isObscure: isObscure));
    });
  }
}

// @override
//   Stream<ObscureState> mapEventToState(ObscureEvent event) async* {
//     if (event is IsObscureEvent) {
//       yield IsObscureState(isObscure: !state.isObscure);
//     }
//   }