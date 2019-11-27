import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ieee_mvp/notification_service.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key key,
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

  @override
  void initState() {
    super.initState();
    initialPosition = CameraPosition(
      target: LatLng(
        0,
        0,
      ),
      zoom: 4.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Stack(
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
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              child: Icon(
                Icons.my_location,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Colors.white,
              elevation: 3,
            ),
          ),
          Positioned(
            bottom: 16,
            child: RaisedButton(
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Firestore.instance.collection('orders').add({
                  'username': 'byshy',
                  'location': GeoPoint(
                    selectedLocation.target.latitude,
                    selectedLocation.target.longitude,
                  ),
                  'date': DateTime.now().toIso8601String(),
                  'quantity': 10,
                });
                sendAndRetrieveMessage();
              },
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
          zoom: 12,
        ),
      ),
    );
  }
}
