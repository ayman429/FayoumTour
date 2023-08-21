import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/change_password_usecase.dart';
import '../../domain/usecase/get_user_details_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/registration_usecase.dart';
import '../../domain/usecase/reset_password_confirm_usecase.dart';
import '../../domain/usecase/reset_password_usecase.dart';
import '../../domain/usecase/update_user_details_usecase.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserDetailsUsecase getUserDetailsUsecase;
  final LoginUsecase loginUsecase;
  final RegisterationUsecase registerationUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final UpdateUserDetailsUsecase updateUserDetailsUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final ResetPasswordConfirmUsecase resetPasswordConfirmUsecase;
  final LogoutUsecase logoutUsecase;
  AuthenticationBloc(
      this.getUserDetailsUsecase,
      this.loginUsecase,
      this.registerationUsecase,
      this.logoutUsecase,
      this.changePasswordUsecase,
      this.updateUserDetailsUsecase,
      this.resetPasswordUsecase,
      this.resetPasswordConfirmUsecase)
      : super(AuthenticationState()) {
    on<GetUserDetailsEvent>(_getUserDetails);
    on<LoginEvent>(_login);
    on<RegistrationEvent>(_registration);

    on<ChangePasswordEvent>(_changePassword);
    on<UpdateUserDetailsEvent>(_updateUserDetails);
    on<ResetPasswordEvent>(_resetPassword);
    on<ResetPasswordConfirmEvent>(_resetPasswordConfirm);

    on<LogoutEvent>(_logout);
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
        // print("userDetails: " + r.email);
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
        return emit(state.copyWith(
            registrationstate: RequestState.error,
            registrationMessage: l.message.toString()));
      },
      (r) => emit(state.copyWith(
        registrationstate: RequestState.loaded,
      )),
    );
  }

  FutureOr<void> _changePassword(
      ChangePasswordEvent event, Emitter<AuthenticationState> emit) async {
    (await changePasswordUsecase(event.changePassword)).fold(
      (l) {
        return emit(state.copyWith(
            changePasswordstate: RequestState.error,
            changePasswordMessage: l.message.toString()));
      },
      (r) => emit(state.copyWith(
        changePasswordstate: RequestState.loaded,
      )),
    );
  }

  FutureOr<void> _updateUserDetails(
      UpdateUserDetailsEvent event, Emitter<AuthenticationState> emit) async {
    (await updateUserDetailsUsecase(event.userDetails, event.type)).fold(
      (l) {
        return emit(state.copyWith(
            updateuserDetailsState: RequestState.error,
            updateuserDetailsMessage: l.message.toString()));
      },
      (r) => emit(state.copyWith(
        updateuserDetails: r,
        updateuserDetailsState: RequestState.loaded,
      )),
    );
  }

  FutureOr<void> _resetPassword(
      ResetPasswordEvent event, Emitter<AuthenticationState> emit) async {
    (await resetPasswordUsecase(event.resetPassword)).fold(
      (l) {
        return emit(state.copyWith(
            resetPasswordState: RequestState.error,
            resetPasswordMessage: l.message.toString()));
      },
      (r) => emit(state.copyWith(
        resetPasswordState: RequestState.loaded,
      )),
    );
  }

  FutureOr<void> _resetPasswordConfirm(ResetPasswordConfirmEvent event,
      Emitter<AuthenticationState> emit) async {
    (await resetPasswordConfirmUsecase(event.resetConfirm)).fold(
      (l) {
        return emit(state.copyWith(
            resetPasswordConfirmState: RequestState.error,
            resetPasswordConfirmMessage: l.message.toString()));
      },
      (r) => emit(state.copyWith(
        resetPasswordConfirmState: RequestState.loaded,
      )),
    );
  }

  FutureOr<void> _logout(
      LogoutEvent event, Emitter<AuthenticationState> emit) async {
    (await logoutUsecase(const NoParameters())).fold((l) {
      return emit(state.copyWith(
          logoutstate: RequestState.error,
          logoutMessage: l.message.toString()));
    }, (r) {
      //print("logout: $r");
      return emit(state.copyWith(
        logoutString: r,
        logoutstate: RequestState.loaded,
      ));
    });
  }
}
