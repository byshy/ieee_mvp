import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapUI extends StatelessWidget {
  const MapUI();

  @override
  Widget build(BuildContext context) {
    return const MapUiBody();
  }
}

class MapUiBody extends StatefulWidget {
  const MapUiBody();

  @override
  State<StatefulWidget> createState() => MapUiBodyState();
}

class MapUiBodyState extends State<MapUiBody> {
  MapUiBodyState();

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(-33.852, 151.211),
    zoom: 11.0,
  );

  MapboxMapController mapController;
//  CameraPosition _position = _kInitialPosition;
//  bool _isMoving = false;
  bool _compassEnabled = true;
  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  String _styleString = MapboxStyles.MAPBOX_STREETS;
  bool _rotateGesturesEnabled = true;
  bool _scrollGesturesEnabled = true;
  bool _tiltGesturesEnabled = true;
  bool _zoomGesturesEnabled = true;
  bool _myLocationEnabled = true;
  MyLocationTrackingMode _myLocationTrackingMode = MyLocationTrackingMode.Tracking;

//  void _onMapChanged() {
//    setState(() {
//      _extractMapInfo();
//    });
//  }
//
//  void _extractMapInfo() {
//    _position = mapController.cameraPosition;
//    _isMoving = mapController.isCameraMoving;
//  }

//  @override
//  void dispose() {
//    mapController.removeListener(_onMapChanged);
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    final MapboxMap mapboxMap = MapboxMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: _kInitialPosition,
        trackCameraPosition: false,
        compassEnabled: _compassEnabled,
        cameraTargetBounds: _cameraTargetBounds,
        minMaxZoomPreference: _minMaxZoomPreference,
        styleString: _styleString,
        rotateGesturesEnabled: _rotateGesturesEnabled,
        scrollGesturesEnabled: _scrollGesturesEnabled,
        tiltGesturesEnabled: _tiltGesturesEnabled,
        zoomGesturesEnabled: _zoomGesturesEnabled,
        myLocationEnabled: _myLocationEnabled,
        myLocationTrackingMode: _myLocationTrackingMode,
        onMapClick: (point, latLng) async {
        },
        onCameraTrackingDismissed: () {
          this.setState(() {
            _myLocationTrackingMode = MyLocationTrackingMode.None;
          });
        }
    );

    return Stack(
      children: [
        mapboxMap,
        Align(
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }

  void onMapCreated(MapboxMapController controller) {
    mapController = controller;
//    mapController.addListener(_onMapChanged);
//    _extractMapInfo();
    setState(() {});
  }
}