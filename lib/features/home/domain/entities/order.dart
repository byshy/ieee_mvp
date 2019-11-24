import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String date;
  final double price;

  Order({this.date, this.price});

  @override
  List<Object> get props => [date, price];

}