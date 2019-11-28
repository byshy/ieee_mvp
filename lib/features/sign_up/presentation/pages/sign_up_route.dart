import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_mvp/features/home/presentation/pages/home_route.dart';
import 'package:ieee_mvp/features/sign_up/presentation/sign_up_bloc/bloc.dart';

class SignUpRoute extends StatefulWidget {
  @override
  _SignUpRouteState createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final SignUpBloc _signUpBloc = SignUpBloc();

  @override
  void initState() {
    super.initState();
    userName.text = 'basel';
    email.text = 'baselhadrous99@gmail.com';
    number.text = '0567817018';
    password.text = '123456ab';
    rePassword.text = '123456ab';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create new account'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: userName,
            decoration: InputDecoration(
              hintText: 'UserName',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: number,
            decoration: InputDecoration(
              hintText: 'Number',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: rePassword,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Re-enter password',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          BlocListener(
            bloc: _signUpBloc,
            listener: (BuildContext context, SignUpState state){
              if(state is SignedUp){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeRoute()), (_) => false);
              }
            },
            child: RaisedButton(
              onPressed: () {
                if (password.text.isNotEmpty &&
                    userName.text.isNotEmpty &&
                    email.text.isNotEmpty &&
                    rePassword.text.isNotEmpty &&
                    number.text.isNotEmpty) {
                  if (password.text == rePassword.text) {
                    _signUpBloc.add(SignUp(email: email.text, userName: userName.text, number: number.text, password: password.text));
                  } else {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Password Feilds don\'t match'),
                      ),
                    );
                    setState(() {
                      password.clear();
                      rePassword.clear();
                    });
                  }
                } else {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Can\'t have empty feilds'),
                    ),
                  );
                }
              },
              child: BlocBuilder(
                bloc: _signUpBloc,
                builder: (BuildContext context, SignUpState state){
                  if(state is SigningUp){
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
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ),
          FlatButton(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Already have an account ? ',
                    style: TextStyle(color: Colors.black)),
                TextSpan(text: 'Log In', style: TextStyle(color: Colors.blue)),
              ]),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
