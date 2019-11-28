import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const []]) : super();
}

class SignUp extends SignUpEvent {
  final String userName;
  final String email;
  final String number;
  final String password;

  SignUp({this.userName, this.email, this.number, this.password}) : super([userName, email, number, password]);

  @override
  List<Object> get props => [userName, email, number, password];

}
