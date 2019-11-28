import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_mvp/features/login/presentation/pages/login_route.dart';
import 'package:ieee_mvp/features/login/presentation/login_bloc/bloc.dart';

class Settings extends StatelessWidget {
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener(
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
      ),
    );
  }
}
