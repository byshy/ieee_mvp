import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  final String message;

  Confirmation({this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('confirmation'),
      ),
      body: Center(child: Text(message),),
    );
  }
}
