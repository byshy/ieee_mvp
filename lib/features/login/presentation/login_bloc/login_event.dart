import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class Login extends LoginEvent {
  final String username;
  final String password;

  Login({this.username, this.password}): super([username, password]);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LogOut extends LoginEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}