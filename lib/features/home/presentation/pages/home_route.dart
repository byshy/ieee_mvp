import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_mvp/features/home/domain/entities/category.dart';
import 'package:ieee_mvp/features/home/presentation/home_bloc/bloc.dart';
import 'package:ieee_mvp/features/home/presentation/widgets/export.dart';

import 'export.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  Category _defaultCategory;
  Category _currentCategory;

  final _categories = <Category>[];

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

  Widget _buildCategoryWidgets() {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var _category = _categories[index];
            return CategoryTile(category: _category, onTap: _onCategoryTap);
          },
          itemCount: _categories.length,
        );
      } else {
        return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3.0,
          children: _categories.map((Category c) {
            return CategoryTile(
              category: c,
              onTap: _onCategoryTap,
            );
          }).toList(),
        );
      }
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
      child: _buildCategoryWidgets(),
    );

    _currentCategory??= _defaultCategory;

    int index = _categories.indexOf(_currentCategory);

    List<Widget> widgets = [
      Providers(),
      MainProvider(),
      PastOrders(),
      Settings(),
      Center(
          child: Text(
            'Share app',
            style: TextStyle(fontSize: 30),
          )),
      ContactUs(),
      AboutUs()
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
            Text('${_currentCategory.name}',),
            Spacer(),
            if (index == 0)
              IconButton(onPressed: (){}, icon: Icon(Icons.search),)
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
