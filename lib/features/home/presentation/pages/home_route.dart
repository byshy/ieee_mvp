import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_mvp/features/home/domain/entities/category.dart';
import 'package:ieee_mvp/features/home/presentation/home_bloc/bloc.dart';
import 'package:ieee_mvp/features/home/presentation/pages/confirmation.dart';
import 'package:ieee_mvp/features/home/presentation/widgets/export.dart';
import 'package:ieee_mvp/main.dart';

import 'export.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  Category _defaultCategory;
  Category _currentCategory;

   FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _categories = <Category>[];

  @override
  void initState() {
    _firebaseMessaging = FirebaseMessaging();
    super.initState();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage');
        goToMapFromNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch');
        goToMapFromNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume');
        goToMapFromNotification(message);
      },
    );
  }

  Future<void> goToMapFromNotification(Map message) async {
    print("AAAa _$message");
    try {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        navigatorState.currentState.push(
          MaterialPageRoute(
            builder: (_) => Confirmation(
              message: message.toString(),
            ),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    var providers = Category(
      name: 'Providers',
    );

    var mainProviders = Category(
      name: 'Usual Provider',
    );

    var pastOrders = Category(
      name: 'Past Orders',
    );

    var settings = Category(
      name: 'Settings',
    );

    setState(() {
      _defaultCategory = mainProviders;
      _categories.add(providers);
      _categories.add(mainProviders);
      _categories.add(pastOrders);
      _categories.add(settings);
    });
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var _category = _categories[index];
          return CategoryTile(category: _category, onTap: _onCategoryTap);
        },
        itemCount: _categories.length,
      ),
    );

    _currentCategory ??= _defaultCategory;

    int index = _categories.indexOf(_currentCategory);

    List<Widget> widgets = [
      Providers(),
      MainProvider(),
      PastOrders(),
      Settings(),
    ];

    return BlocProvider.value(
      value: HomeBloc(),
      child: Backdrop(
        currentCategory:
            _currentCategory == null ? _defaultCategory : _currentCategory,
        frontPanel: widgets[index],
        backPanel: listView,
        frontTitle: Row(
          children: <Widget>[
            Text('${_currentCategory.name}'),
            Spacer(),
            if (index == 0)
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              )
          ],
        ),
        backTitle: Row(
          children: <Widget>[
            Text('Select a Category'),
            Spacer(),
            if (index == 0)
              SizedBox(
                height: 48,
              )
          ],
        ),
      ),
    );
  }
}
