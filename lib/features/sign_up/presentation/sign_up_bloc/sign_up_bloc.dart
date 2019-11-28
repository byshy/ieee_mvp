import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  SignUpState get initialState => InitialSignUpState();

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUp) {
      yield SigningUp();
      await _auth
          .createUserWithEmailAndPassword(email: event.email, password: event.password)
          .then((authRes) async {
        Firestore.instance.collection('users').add({
          'uid': authRes.user.uid,
          'name': event.userName,
          'number': event.number,
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('is_logged_in', true);
      });
      yield SignedUp();
    }
  }
}
