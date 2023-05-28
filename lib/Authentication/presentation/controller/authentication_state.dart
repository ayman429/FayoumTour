import '../../../core/utils/enums.dart';
import '../../domain/entities/change_password.dart';
import '../../domain/entities/user_details.dart';

class AuthenticationState {
  /// User Details
  UserDetails? userDetails;
  final RequestState userDetailsState;
  dynamic userDetailsMessage;

  /// Login
  final RequestState loginstate;
  dynamic loginMessage;

  /// Registration
  final RequestState registrationstate;
  dynamic registrationMessage;

  /// Change Password
  // ChangePassword? changePassword;
  final RequestState changePasswordstate;
  dynamic changePasswordMessage;

  /// Update User Details
  String? updateuserDetails;
  final RequestState updateuserDetailsState;
  dynamic updateuserDetailsMessage;

  /// Reset Password
  final RequestState resetPasswordState;
  dynamic resetPasswordMessage;

  /// Reset Password Confirm
  final RequestState resetPasswordConfirmState;
  dynamic resetPasswordConfirmMessage;

  /// Logout
  dynamic logoutString;
  final RequestState logoutstate;
  dynamic logoutMessage;

  AuthenticationState({
    this.userDetails,
    this.userDetailsState = RequestState.loading,
    this.userDetailsMessage = '',
    this.loginstate = RequestState.loading,
    this.loginMessage = '',
    this.registrationstate = RequestState.loading,
    this.registrationMessage = '',
    // this.changePassword,
    this.changePasswordstate = RequestState.loading,
    this.changePasswordMessage = '',
    this.updateuserDetails,
    this.updateuserDetailsState = RequestState.loading,
    this.updateuserDetailsMessage = '',
    this.resetPasswordState = RequestState.loading,
    this.resetPasswordMessage = '',
    this.resetPasswordConfirmState = RequestState.loading,
    this.resetPasswordConfirmMessage = '',
    this.logoutString,
    this.logoutstate = RequestState.loading,
    this.logoutMessage = '',
  });
  AuthenticationState copyWith({
    UserDetails? userDetails,
    RequestState? userDetailsState,
    dynamic userDetailsMessage,
    RequestState? loginstate,
    dynamic loginMessage,
    RequestState? registrationstate,
    dynamic registrationMessage,

    /// Change Password
    ChangePassword? changePassword,
    RequestState? changePasswordstate,
    dynamic changePasswordMessage,

    /// Update User Details
    String? updateuserDetails,
    RequestState? updateuserDetailsState,
    dynamic updateuserDetailsMessage,

    /// Reset Password
    RequestState? resetPasswordState,
    dynamic resetPasswordMessage,

    /// Reset Password Confirm
    RequestState? resetPasswordConfirmState,
    dynamic resetPasswordConfirmMessage,
    dynamic logoutString,
    RequestState? logoutstate,
    dynamic logoutMessage,
  }) {
    return AuthenticationState(
      userDetails: userDetails ?? this.userDetails,
      userDetailsState: userDetailsState ?? this.userDetailsState,
      userDetailsMessage: userDetailsMessage ?? this.userDetailsMessage,
      loginMessage: loginMessage ?? this.loginMessage,
      loginstate: loginstate ?? this.loginstate,
      registrationMessage: registrationMessage ?? this.registrationMessage,
      registrationstate: registrationstate ?? this.registrationstate,
      // changePassword: changePassword ?? this.changePassword,
      changePasswordMessage:
          changePasswordMessage ?? this.changePasswordMessage,
      changePasswordstate: changePasswordstate ?? this.changePasswordstate,
      updateuserDetails: updateuserDetails ?? this.updateuserDetails,
      updateuserDetailsMessage:
          updateuserDetailsMessage ?? this.updateuserDetailsMessage,
      updateuserDetailsState:
          updateuserDetailsState ?? this.updateuserDetailsState,
      resetPasswordMessage: resetPasswordMessage ?? this.resetPasswordMessage,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      resetPasswordConfirmMessage:
          resetPasswordConfirmMessage ?? this.resetPasswordConfirmMessage,
      resetPasswordConfirmState:
          resetPasswordConfirmState ?? this.resetPasswordConfirmState,
      logoutString: logoutString ?? this.logoutString,
      logoutMessage: logoutMessage ?? this.logoutMessage,
      logoutstate: logoutstate ?? this.logoutstate,
    );
  }
}
