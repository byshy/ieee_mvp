import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

final String serverToken =
    'AAAAYJCJNU4:APA91bFY1f3lZ054UppcOp4EICJ_565ppyQhImsqvJ9YtmzrByyqDp1vBm3wP4NhLDYdXcIEZj7K_hB0wlQr27fcZ1YWAaQyTsraRwWjmcVgGr5lcKYocu9W0thtNj8Hx08z81iBcXrM';
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

Future<Map<String, dynamic>> sendAndRetrieveMessage({String name, String quantity, GeoPoint location, String date}) async {
  http.Response response = await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': '$name ordered $quantity from you',
          'title': 'New Order'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'screen': 'confirmation',
          'id': '1',
          'status': 'done',
          'order': <String, dynamic>{
            'username': name,
            'long': location.longitude.toString(),
            'lat': location.latitude.toString(),
            'date': date,
            'quantity': quantity,
          }
        },
        'to': '/topics/provider',
      },
    ),
  );

  print(response.statusCode);
  print(response?.body);

  final Completer<Map<String, dynamic>> completer =
      Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
    },
  );

  return completer.future;
}
