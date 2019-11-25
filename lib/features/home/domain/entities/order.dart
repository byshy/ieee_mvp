import 'package:ieee_mvp/features/home/data/data_src/orders_db.dart';

class Order {
  int id;
  String date;
  double price;

  Order({this.date, this.price, this.id});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnID: id,
      columnDate: date,
      columnPrice: price,
    };
    if (id != null) {
      map[columnID] = id;
    }
    return map;
  }

  Order.fromMap(Map<String, dynamic> map) {
    id = map[columnID];
    date = map[columnDate];
    price = map[columnPrice];
  }

}