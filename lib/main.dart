import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_bloc/bloc.dart';
import 'features/home/presentation/pages/home_route.dart';
import 'features/login/presentation/pages/login_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IEEE MVP',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonColor: Color(0xFF1976D2),
          textTheme:
              TextTheme(headline: TextStyle(color: Colors.white, fontSize: 18)),
          accentColor: Color(0xFF1976D2),
          cursorColor: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(
                color: Colors.blue,
              ),
            ),
          )),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// is this file the app checks to see if the
  /// user had already logged in before or not then
  /// route the user to the appropriate destination
  final AppBloc appBloc = new AppBloc();

  @override
  void initState() {
    super.initState();

    /// start the check
    appBloc.add(CheckLogin());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: appBloc,
      builder: (BuildContext context, AppState state) {
        if (state is FinishLoginCheck) {
          if (state.isLoggedIn) {
            return HomeRoute();
          } else {
            return LoginRoute();
          }
        }
        return Container();
      },
    );
  }
}
