import 'package:flutter/material.dart';
import 'package:ieee_mvp/features/home/domain/entities/order.dart';
import 'package:ieee_mvp/features/home/presentation/pages/map_page.dart';
import 'package:location/location.dart';

import 'map_ui.dart';

class MainProvider extends StatefulWidget {
  final String location;
  final String mobile;
  final bool hideName;

  const MainProvider({Key key, this.location, this.mobile, this.hideName = false}) : super(key: key);

  @override
  _MainProviderState createState() => _MainProviderState();
}

class _MainProviderState extends State<MainProvider> {
  bool isSubscribed = false;

  List<Order> orders = [];

  void _pushPage(BuildContext context, Widget page) async {
    final Location location = Location();
    final hasPermissions = await location.hasPermission();
    if (!hasPermissions) {
      await location.requestPermission();
    }

    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => page));
  }

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < 20; i++){
      orders.add(Order(
        date: 'some date  #$i',
        price: i * 1.25,
      ));
    }
  }

  Widget buildHeader() {
    return Column(
      children: <Widget>[
        ListTile(
          title: widget.hideName ? Text(widget.location) : Text('Provider Name (local)'),
          subtitle: !widget.hideName ? Text('Provider Location (local)') : null,
          trailing: IconButton(
            icon: Icon(Icons.beenhere,
                color: isSubscribed ? Colors.blue : Colors.grey[900]),
            onPressed: () {
              setState(() {
                isSubscribed = !isSubscribed;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))
              ),
              onPressed: (){},
              child: Icon(Icons.call),
            ),
            FlatButton(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))
              ),
              onPressed: (){},
              child: Icon(Icons.map),
            ),
            FlatButton(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))
              ),
              onPressed: (){},
              child: Icon(Icons.rate_review),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 60),
                itemCount: orders.length,
                itemBuilder: (context, position) {
                  return ListTile(
                    title: Text(orders[position].date),
                    trailing: Text('\$${orders[position].price.toString()}'),
                  );
                },
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 100,
            margin: EdgeInsets.all(10),
            child: Material(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _pushPage(context, MapPage());
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
