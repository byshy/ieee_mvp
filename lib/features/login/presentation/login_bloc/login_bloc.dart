import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

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
      FirebaseUser user = await logIn(email: event.email, password: event.password);
      if(user != null){
        prefs.setBool('is_logged_in', true);
        yield LoggedIn();
      } else {
        yield LogInError();
      }
    } else if(event is LogOut){
      yield LoggingOut();
      FirebaseAuth.instance.signOut();
      prefs.setBool('is_logged_in', false);
      yield LoggedOut();
    }
  }

  Future<FirebaseUser> logIn({String email, String password}) async {
    FirebaseUser user;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((res){
        user = res.user;
      });
    } catch (e){
      authProblems errorType;
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
        // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            errorType = authProblems.UserNotFound;
            break;
          case 'Error 17009':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = authProblems.NetworkError;
            break;
        // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
      print('The error is $errorType');
    }
    return user;
  }

}