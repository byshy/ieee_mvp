import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieee_mvp/common/custom_button.dart';
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
  final FocusNode userNameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode numberNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode rePasswordNode = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignUpBloc _signUpBloc = SignUpBloc();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create new account'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: userName,
              focusNode: userNameNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'UserName',
                prefixIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                userNameNode.unfocus();
                emailNode.requestFocus();
              },
              keyboardType: TextInputType.text,
              validator: (value) {
                if ((value?.isEmpty ?? true)) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: email,
              focusNode: emailNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                emailNode.unfocus();
                numberNode.requestFocus();
              },
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if ((value?.isEmpty ?? true) || !value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: number,
              focusNode: numberNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Phone Number',
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                numberNode.unfocus();
                passwordNode.requestFocus();
              },
              keyboardType: TextInputType.number,
              validator: (value) {
                if ((value?.isEmpty ?? true)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: password,
              focusNode: passwordNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Password',
                prefixIcon: Icon(
                  Icons.lock_open,
                  color: Theme.of(context).primaryColor,
                ),
                suffixIcon: IconButton(
                  padding: const EdgeInsets.only(right: 16),
                  icon: Icon(
                    _hidePassword
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Theme.of(context).primaryColor,
                  ),
                  splashColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
              ),
              onFieldSubmitted: (_) {
                passwordNode.unfocus();
                rePasswordNode.requestFocus();
              },
              keyboardType: TextInputType.emailAddress,
              obscureText: _hidePassword,
              validator: (value) {
                if ((value?.isEmpty ?? true) || value.length < 6) {
                  return 'Please enter a valid password';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: rePassword,
              focusNode: rePasswordNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Password Again',
                prefixIcon: Icon(
                  Icons.lock_open,
                  color: Theme.of(context).primaryColor,
                ),
                suffixIcon: IconButton(
                  padding: const EdgeInsets.only(right: 16),
                  icon: Icon(
                    _hidePassword
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Theme.of(context).primaryColor,
                  ),
                  splashColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
              ),
              onFieldSubmitted: (_) {
                rePasswordNode.unfocus();
                login();
              },
              keyboardType: TextInputType.emailAddress,
              obscureText: _hidePassword,
              validator: (value) {
                if ((value?.isEmpty ?? true) ||
                    value.length < 6 ||
                    value != password.text) {
                  return 'Please enter a valid password';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            BlocListener(
              bloc: _signUpBloc,
              listener: (BuildContext context, SignUpState state) {
                if (state is SignedUp) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomeRoute()),
                      (_) => false);
                }
              },
              child: CustomButton(
                onTap: () {
                  login();
                },
                child: BlocBuilder(
                  bloc: _signUpBloc,
                  builder: (BuildContext context, SignUpState state) {
                    if (state is SigningUp) {
                      return Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    }

                    return Text(
                      'Sign Up',
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
                  TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      )),
                ]),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!_formKey.currentState.validate()) return;
    _signUpBloc.add(SignUp(
        email: email.text,
        userName: userName.text,
        number: number.text,
        password: password.text));
  }
}
