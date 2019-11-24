import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super();
}

class InitialAppState extends AppState {
  @override
  List<Object> get props => [];
}

class StartLoginCheck extends AppState {
  @override
  List<Object> get props => [];
}

class FinishLoginCheck extends AppState {
  final bool isLoggedIn;

  FinishLoginCheck({this.isLoggedIn}): super([isLoggedIn]);

  @override
  List<Object> get props => [];
}
