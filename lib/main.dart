import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_mvp/features/login/presentation/pages/login_page.dart';

import 'core/app_bloc/bloc.dart';
import 'features/home/presentation/pages/home_route.dart';

GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      title: 'IEEE MVP',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          buttonColor: Colors.teal[200],
          textTheme:
          TextTheme(headline: TextStyle(color: Colors.white, fontSize: 18)),
          accentColor: Colors.teal,
          cursorColor: Colors.teal[200],
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(
                color: Colors.teal[200],
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
            return LoginPage();
          }
        }
        return Container();
      },
    );
  }
}
