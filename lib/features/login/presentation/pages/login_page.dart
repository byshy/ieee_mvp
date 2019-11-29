import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieee_mvp/common/custom_button.dart';
import 'package:ieee_mvp/features/home/presentation/pages/home_route.dart';
import 'package:ieee_mvp/features/login/presentation/login_bloc/bloc.dart';
import 'package:ieee_mvp/features/sign_up/presentation/pages/sign_up_route.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginBloc loginBloc = LoginBloc();

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                Icon(
                  FontAwesomeIcons.truck,
                  color: Theme.of(context).primaryColor,
                  size: 72,
                ),
                SizedBox(height: 16),
                Text(
                  'Utilities',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 4),
                TextFormField(
                  controller: username,
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
                    passwordNode.requestFocus();
                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if ((value?.isEmpty ?? true) || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
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
                    _formKey.currentState.validate();
                    login();
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
                SizedBox(height: 32),
                BlocListener(
                  bloc: loginBloc,
                  listener: (BuildContext context, LoginState state) {
                    if (state is LoggedIn) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeRoute()),
                          (_) => false);
                    } else if (state is LogInError) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content:
                              Text('Something went wrong, please try again'),
                        ),
                      );
                    }
                  },
                  child: CustomButton(
                    onTap: () {
                      if (!_formKey.currentState.validate()) return;
                      login();
                    },
                    child: BlocBuilder(
                      bloc: loginBloc,
                      builder: (BuildContext context, LoginState state) {
                        if (state is LoggingIn) {
                          return Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          );
                        }

                        return Text(
                          'LOG IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Don\'t have an account?'),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUpRoute()));
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    loginBloc.add(Login(email: username.text, password: password.text));
  }
}
