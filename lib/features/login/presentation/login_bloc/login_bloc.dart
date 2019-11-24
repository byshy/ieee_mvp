import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SharedPreferences prefs;

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    prefs = await SharedPreferences.getInstance();
    if(event is Login){
      yield LoggingIn();
      //TODO add log in logic here
      await Future.delayed(Duration(milliseconds: 500,));
      prefs.setBool('is_logged_in', true);
      yield LoggedIn();
    } else if(event is LogOut){
      yield LoggingOut();
      //TODO add log in logic here
      await Future.delayed(Duration(milliseconds: 500,));
      prefs.setBool('is_logged_in', false);
      yield LoggedOut();
    }
  }
}
