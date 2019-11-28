import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_mvp/features/home/presentation/pages/home_route.dart';
import 'package:ieee_mvp/features/login/presentation/login_bloc/bloc.dart';
import 'package:ieee_mvp/features/sign_up/presentation/pages/sign_up_route.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final LoginBloc loginBloc = LoginBloc();

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final FocusNode passwordFocus = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'App name',
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 292,
            child: Card(
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: username,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Visibility(
                          visible: false,
                          child: Icon(
                            Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: password,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: passwordFocus,
                      obscureText: hideText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: hideText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hideText = !hideText;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {},
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    Center(
                      child: BlocListener(
                        bloc: loginBloc,
                        listener: (BuildContext context, LoginState state) {
                          if (state is LoggedIn) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeRoute()),
                                (_) => false);
                          } else if (state is LogInError){
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Something went wrong, please try again'),
                              ),
                            );
                          }
                        },
                        child: RaisedButton(
                          onPressed: () {
                            loginBloc.add(Login(email: username.text, password: password.text));
                          },
                          child: BlocBuilder(
                            bloc: loginBloc,
                            builder:
                                (BuildContext context, LoginState state) {
                              if (state is LoggingIn) {
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
                                'Login',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpRoute()));
                        },
                        child: Text('Or Create Account'),
                      ),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(40),
                topRight: const Radius.circular(40),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
