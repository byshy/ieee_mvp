import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_mvp/features/home/presentation/home_bloc/bloc.dart';
import 'package:ieee_mvp/features/login/presentation/pages/login_route.dart';
import 'package:ieee_mvp/features/login/presentation/login_bloc/bloc.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final LoginBloc loginBloc = LoginBloc();

  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetUser());
  }

  final TextStyle style = TextStyle(
    fontSize: 18
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          BlocBuilder(
            bloc: _homeBloc,
            builder: (BuildContext context, HomeState state) {
              if(state is SettingsLoaded){
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Name', style: style,),
                        Spacer(),
                        Text(state.name, style: style,),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Email', style: style,),
                        Spacer(),
                        Text(state.email, style: style,),
                      ],
                    ),
                  ],
                );
              }

              return CircularProgressIndicator();
            },
          ),
          Spacer(),
          BlocListener(
            bloc: loginBloc,
            listener: (BuildContext context, LoginState state) {
              if (state is LoggedOut) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_) => LoginRoute()), (_) => false);
              }
            },
            child: RaisedButton(
              onPressed: () {
                loginBloc.add(LogOut());
              },
              child: BlocBuilder(
                bloc: loginBloc,
                builder: (BuildContext context, LoginState state) {
                  if (state is LoggingOut) {
                    return Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(
                            Colors.white),
                      ),
                    );
                  }

                  return Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
