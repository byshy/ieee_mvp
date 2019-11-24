import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super();
}

class CheckLogin extends AppEvent {

  @override
  // TODO: implement props
  List<Object> get props => null;

}