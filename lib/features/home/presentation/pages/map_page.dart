import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ieee_mvp/features/home/data/data_src/orders_db.dart';
import 'package:ieee_mvp/notification_service.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final double lat;
  final double long;

  const MapPage({
    Key key,
    this.lat,
    this.long,
  }) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  GoogleMapController _controller;
  CameraPosition initialPosition;
  LocationData _currentLocation;
  var location = Location();
  CameraPosition selectedLocation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int quantity = 0;

  @override
  void initState() {
    super.initState();
    initialPosition = CameraPosition(
      target: LatLng(widget.lat, widget.long),
      zoom: 17,
    );
    selectedLocation = initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initialPosition,
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  onCameraMove: (position) {
                    selectedLocation = position;
                  },
                ),
                Icon(Icons.location_on),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: _getCurrentLocation,
                      icon: Icon(
                        Icons.my_location,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text('Quantitiy'),
                SizedBox(
                  width: 10,
                ),
                DropdownButton<int>(
                  hint: Text(quantity.toString()),
                  items:
                      <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int newValue) {
                    setState(() {
                      quantity = newValue;
                    });
                  },
                ),
                Spacer(),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(quantity != 0){
                      String name =
                      await FirebaseAuth.instance.currentUser().then((user) {
                        return user.displayName;
                      });
                      String date = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
                      Firestore.instance.collection('orders').add({
                        'username': name,
                        'location': GeoPoint(
                          selectedLocation.target.latitude,
                          selectedLocation.target.longitude,
                        ),
                        'date': date,
                        'quantity': quantity,
                      });
                      DbProvider.instance.insertOrder(
                          long: selectedLocation.target.longitude,
                          lat: selectedLocation.target.latitude,
                          quantity: quantity,
                          date: date);
                      sendAndRetrieveMessage(
                          name: name,
                          quantity: quantity.toString(),
                          location: GeoPoint(
                            selectedLocation.target.latitude,
                            selectedLocation.target.longitude,
                          ),
                          date: date);
                      Navigator.pop(context);
                    } else {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Can\'t have 0 quantity'),action: SnackBarAction(onPressed: (){}, label: 'OK',),));
                    }
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await location.getLocation();
      selectedLocation = CameraPosition(
          target: LatLng(
        _currentLocation.latitude,
        _currentLocation.longitude,
      ));
    } on Exception {
      _currentLocation = null;
    }
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentLocation?.latitude,
            _currentLocation?.longitude,
          ),
          zoom: 17,
        ),
      ),
    );
  }
}
