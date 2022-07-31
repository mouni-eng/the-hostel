class AuthStates {}

class OnBackRegistrationStep extends AuthStates {}

class OnNextRegistrationStep extends AuthStates {}

class OnChangeState extends AuthStates {}

class ChooseProfileImageState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  String? error;
  RegisterErrorState({this.error});
}

class LogInLoadingState extends AuthStates {}

class LogInSuccessState extends AuthStates {}

class LogInErrorState extends AuthStates {
  String? error;
  LogInErrorState({this.error});
}

class OtpConfirmedLoadingState extends AuthStates {}

class OtpConfirmedSuccessState extends AuthStates {
  /*final LoginResponse loginResponse;

  EmailConfirmedState(this.loginResponse);*/
}

class OtpConfirmedErrorState extends AuthStates {
  String? error;
  OtpConfirmedErrorState({this.error});
}

class CodeSentState extends AuthStates {

}