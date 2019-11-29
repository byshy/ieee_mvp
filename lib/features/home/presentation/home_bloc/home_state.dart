import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super();
}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingSettings extends HomeState {
  @override
  List<Object> get props => null;
}

class SettingsLoaded extends HomeState {
  final String name;
  final String email;

  SettingsLoaded({this.name, this.email}): super([name, email]);

  @override
  List<Object> get props => [name, email];
}
