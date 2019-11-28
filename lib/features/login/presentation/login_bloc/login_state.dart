import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggingIn extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggedIn extends LoginState {
  @override
  List<Object> get props => [];
}

class LogInError extends LoginState {
  final String errorMsg;

  LogInError({this.errorMsg}) : super([errorMsg]);

  @override
  List<Object> get props => [errorMsg];
}

class LoggingOut extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggedOut extends LoginState {
  @override
  List<Object> get props => [];
}