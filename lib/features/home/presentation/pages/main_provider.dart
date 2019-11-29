import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieee_mvp/features/home/data/data_src/orders_db.dart';
import 'package:ieee_mvp/features/home/domain/entities/order.dart';
import 'package:ieee_mvp/features/home/presentation/pages/map_page.dart';
import 'package:ieee_mvp/notification_service.dart';
import 'package:location/location.dart';
import 'package:unicorndial/unicorndial.dart';

class MainProvider extends StatefulWidget {
  final String location;
  final String mobile;
  final bool hideName;

  const MainProvider(
      {Key key, this.location, this.mobile, this.hideName = false})
      : super(key: key);

  @override
  _MainProviderState createState() => _MainProviderState();
}

class _MainProviderState extends State<MainProvider> {
  var location = Location();

  bool isSubscribed = false;

  List<Order> orders = [];

  Widget _profileOption(
      {IconData iconData, String heroTag, Function onPressed, String label}) {
    return UnicornButton(
        hasLabel: true,
        labelText: label,
        currentButton: FloatingActionButton(
          heroTag: heroTag,
          backgroundColor: Colors.grey[500],
          mini: true,
          child: Icon(
            iconData,
            color: Colors.white,
          ),
          onPressed: onPressed,
        ));
  }

  List<UnicornButton> _getProfileMenu() {
    List<UnicornButton> children = [];

    children.add(_profileOption(
        iconData: Icons.rate_review,
        onPressed: () {},
        heroTag: 'tag3',
        label: 'rate and review'));
    children.add(_profileOption(
        iconData: Icons.map,
        onPressed: () {},
        heroTag: 'tag2',
        label: 'show on map'));
    children.add(_profileOption(
        iconData: Icons.call,
        onPressed: () {},
        heroTag: 'tag1',
        label: 'call'));

    return children;
  }

  void _pushPage(BuildContext context, Widget page) async {
    final Location location = Location();
    final hasPermissions = await location.hasPermission();
    if (!hasPermissions) {
      await location.requestPermission();
    }

    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  Future<List<Order>> ordersFromDb;

  @override
  void initState() {
    super.initState();
    ordersFromDb = DbProvider.instance.getOrders();
  }

  Widget buildHeader() {
    return Column(
      children: <Widget>[
        ListTile(
          title: widget.hideName
              ? Text(widget.location)
              : Text('Provider Name (local)'),
          subtitle: !widget.hideName ? Text('Provider Location (local)') : null,
          trailing: InkWell(
            child: Container(
              padding: const EdgeInsets.all(4),
              color: isSubscribed
                  ? Colors.white
                  : Theme.of(context).primaryColor.withAlpha(50),
              child: Text(
                isSubscribed ? 'Subscribed' : 'Subscribe',
              ),
            ),
          ),
          onTap: () {
            setState(() {
              isSubscribed = !isSubscribed;
            });
          },
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: FlatButton(
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () async {
                  LocationData _currentLocation = await location.getLocation();
                  _pushPage(
                      context,
                      MapPage(
                        lat: _currentLocation.latitude,
                        long: _currentLocation.longitude,
                      ));
                },
                child: Text(
                  'New Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: FlatButton(
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () async {
                  Order order = await DbProvider.instance.getLastOrder();

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Send last order?'),
                          content:
                              Text('''Last order quantity: ${order.quantity}
Date: ${order.date}'''),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            FlatButton(
                              onPressed: () async {
                                String name = await FirebaseAuth.instance
                                    .currentUser()
                                    .then((user) {
                                  return user.displayName;
                                });
                                String date = DateTime.now().toIso8601String();
                                Firestore.instance.collection('orders').add({
                                  'username': name,
                                  'location': GeoPoint(
                                    order.lat,
                                    order.long,
                                  ),
                                  'date': date,
                                  'quantity': order.quantity,
                                });
                                DbProvider.instance.insertOrder(
                                    long: order.lat,
                                    lat: order.long,
                                    quantity: order.quantity,
                                    date: date);
                                sendAndRetrieveMessage(
                                    name: name,
                                    quantity: order.quantity.toString(),
                                    location: GeoPoint(
                                      order.lat,
                                      order.long,
                                    ),
                                    date: date);
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              child: Text('Send'),
                              color:
                                  Theme.of(context).primaryColor.withAlpha(50),
                            ),
                          ],
                        );
                      });
                },
                child: Text(
                  'Repeat last Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 10,
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
              child: FutureBuilder<List<Order>>(
                future: DbProvider.instance.getOrders(),
                // initialData: List(),
                builder: (_, snapshot) {
                  print('snapshot');
                  print(snapshot.data);
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 60),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, position) {
                        Order order = snapshot.data[position];
                        return ListTile(
                          title: Text(order.date),
                          trailing: Text('${order.quantity.toString()}'),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Text('No Orders yet'),
                  );
                },
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnicornDialer(
//              animationDuration: 0,
              backgroundColor: Color(0x00FFFFFF),
              parentButtonBackground: Theme.of(context).primaryColor,
              orientation: UnicornOrientation.VERTICAL,
              parentButton: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              childButtons: _getProfileMenu(),
            ),
          ),
        )
      ],
    );
  }
}
