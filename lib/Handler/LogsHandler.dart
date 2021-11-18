// ignore_for_file: file_names

import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rethink/Screens/SignInScreen.dart';
import 'package:rethink/System/AppRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogsHandler {
  final firestoreInstance = FirebaseFirestore.instance;

  Future scannedActivityLogUpdate(String activity, 
  String productid, String lat, String long, String city, 
  String state, String country, bool isSignIn) async{
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('UserID').toString();
    await initializeDateFormatting();
    final dateTimeNow = DateTime.now();
    String timeFormater = DateFormat.jms().format(dateTimeNow);
    String dateFormater = DateFormat('yMMMd').format(dateTimeNow);
    
    firestoreInstance.collection("logs").doc()
    .set(
    {
      "activity": activity,
      "time": timeFormater,
      "date": dateFormater,
      "productId": productid,
      "batchId": "batchID",
      "deviceType": "",
      "isLogin": isSignIn,
      "userId": isSignIn ? id : "",
      "userType": "consumer",
      "brandOwner": "Nets Eco Hauz Sdn Bhd",
      "brand": "Rethink",
      "productName": "Rethink Demo Pharmaceutical 1.0",
      "location": {
        "latitude": lat,
        "longitude": long,
        "city": city,
        "state": state,
        "country": country,
      }
    }).then((value){
      print('logs updated');
    });
  }
}