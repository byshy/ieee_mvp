import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class Login extends LoginEvent {
  final String email;
  final String password;

  Login({this.email, this.password}): super([email, password]);

  @override
  List<Object> get props => [email, password];
}

class LogOut extends LoginEvent {
  @override
  List<Object> get props => null;
}