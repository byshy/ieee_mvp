import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class InitialSignUpState extends SignUpState {
  @override
  List<Object> get props => [];
}
