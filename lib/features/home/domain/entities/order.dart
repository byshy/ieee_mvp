import 'package:ieee_mvp/features/home/data/data_src/orders_db.dart';

class Order {
  int id;
  String date;
  int quantity;
  double lat, long;

  Order({this.date, this.quantity, this.id, this.long, this.lat});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnID: id,
      columnDate: date,
      columnQuantity: quantity,
      columnLat: lat,
      columnLong: long,
    };
    if (id != null) {
      map[columnID] = id;
    }
    return map;
  }

  Order.fromMap(Map<String, dynamic> map) {
    id = map[columnID];
    date = map[columnDate];
    quantity = map[columnQuantity];
    lat = map[columnLat];
    long = map[columnLong];
  }

  @override
  String toString() {
    return 'id $date $quantity $lat $long';
  }

}