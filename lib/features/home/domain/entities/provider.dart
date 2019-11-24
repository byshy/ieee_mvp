import 'package:equatable/equatable.dart';

class Provider extends Equatable {
  final String name;
  final String location;
  final String mobile;
  final double long;
  final double lat;

  Provider({this.name, this.location, this.mobile, this.long, this.lat});

  @override
  List<Object> get props => [name, location, mobile, long, lat];

}