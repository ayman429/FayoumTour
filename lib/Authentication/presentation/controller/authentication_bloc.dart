import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/get_user_details_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/registration_usecase.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserDetailsUsecase getUserDetailsUsecase;
  final LoginUsecase loginUsecase;
  final RegisterationUsecase registerationUsecase;
  AuthenticationBloc(
      this.getUserDetailsUsecase, this.loginUsecase, this.registerationUsecase)
      : super(AuthenticationState()) {
    on<GetUserDetailsEvent>(_getUserDetails);
    on<LoginEvent>(_login);
    on<RegistrationEvent>(_registration);
  }

  FutureOr<void> _getUserDetails(
      GetUserDetailsEvent event, Emitter<AuthenticationState> emit) async {
    // List<UserDetails> list = [];
    (await getUserDetailsUsecase(const NoParameters())).fold(
      (l) {
        return emit(state.copyWith(
          userDetailsState: RequestState.error,
          userDetailsMessage: l.message,
        ));
      },
      (r) {
        // list.add(r);
        print(r.email);
        // list.add(r);
        return emit(state.copyWith(
          userDetails: r,
          userDetailsState: RequestState.loaded,
        ));
      },
    );
  }

  FutureOr<void> _login(
      LoginEvent event, Emitter<AuthenticationState> emit) async {
    (await loginUsecase(event.login)).fold(
      (l) {
        return emit(state.copyWith(
            loginstate: RequestState.error, loginMessage: l.message.toString()
            // .substring(
            //     l.message.toString().indexOf(AppStrings.rightBracket) + 2,
            //     l.message.toString().indexOf(AppStrings.leftBracket) - 2),
            ));
      },
      (r) => emit(state.copyWith(
        loginstate: RequestState.loaded,
      )),
    );
  }

  FutureOr<void> _registration(
      RegistrationEvent event, Emitter<AuthenticationState> emit) async {
    (await registerationUsecase(event.registration)).fold(
      (l) {
        print("Error Massage: ${l.message}");
        return emit(state.copyWith(
            registrationstate: RequestState.error,
            registrationMessage: l.message
            // .substring(
            //     l.message.toString().indexOf(AppStrings.rightBracket) + 2,
            //     l.message.toString().indexOf(AppStrings.leftBracket) - 2),
            ));
      },
      (r) => emit(state.copyWith(
        registrationstate: RequestState.loaded,
      )),
    );
  }
}
