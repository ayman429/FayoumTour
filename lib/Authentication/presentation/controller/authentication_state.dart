import '../../../core/utils/enums.dart';
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
      logoutString: logoutString ?? this.logoutString,
      logoutMessage: logoutMessage ?? this.logoutMessage,
      logoutstate: logoutstate ?? this.logoutstate,
    );
  }
}
