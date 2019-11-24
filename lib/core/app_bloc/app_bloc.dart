import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  SharedPreferences prefs;

  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    prefs = await SharedPreferences.getInstance();
    if(event is CheckLogin){
      yield StartLoginCheck();
      final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      yield FinishLoginCheck(isLoggedIn: isLoggedIn);
    }
  }
}
