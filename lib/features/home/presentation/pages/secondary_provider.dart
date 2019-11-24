import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieee_mvp/features/home/domain/entities/provider.dart';
import 'package:ieee_mvp/features/home/presentation/pages/export.dart';

class SecondaryProvider extends StatefulWidget {
  final Provider provider;

  const SecondaryProvider({Key key, this.provider}) : super(key: key);

  @override
  _SecondaryProviderState createState() => _SecondaryProviderState();
}

class _SecondaryProviderState extends State<SecondaryProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.provider.name, style: TextStyle(
          color: Colors.black
        ),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: MainProvider(hideName: true, mobile: widget.provider.mobile, location: widget.provider.location,),
    );
  }


}
