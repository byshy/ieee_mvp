import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event is GetUser){
      yield LoadingSettings();
      String name = prefs.getString('name');
      String email = prefs.getString('email');
      yield SettingsLoaded(name: name, email: email);
    }
  }
}
