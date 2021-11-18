// ignore_for_file: file_names

import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:rethink/Services/AuthApplicationIdServices.dart';
import 'package:rethink/Services/GetEntityListServices.dart';
import 'package:rethink/System/Routes.dart';
import 'package:rethink/System/Theme.dart';
import 'package:rethink/main.dart' as main;
import 'package:rethink/Screens/SignInScreen.dart';
import 'package:rethink/System/AppRoutes.dart' as route;
import 'package:qlevar_router/qlevar_router.dart';
import 'package:rethink/System/CosmoDBServices.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rethink/Model/user.dart' as user;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rethink/Screens/UserProfileScreen.dart';
import 'package:location/location.dart' as loc;
import 'package:google_geocoding/google_geocoding.dart';
import 'package:rethink/Screens/LocationDeniedScreen.dart';
import 'package:rethink/Handler/LogsHandler.dart';
import 'dart:html' as html;

bool? isSignIn = false;

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  
  const HomeScreen({ Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
  
}

class HomeScreenState extends State<HomeScreen> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  loc.Location location = loc.Location();
  late bool _serviceLocationEnabled;
  bool _permissionLocation = true;
  late  loc.PermissionStatus _permissionGranted;
  late  loc.LocationData _locationData;
  var googleGeocoding = GoogleGeocoding("AIzaSyBUcEdfuX-shQ1IOiRnyEepN_AxZj0p_hQ");
  List<GeocodingResult> reverseGeocodingResults = [];
  late bool urlIsValid = false;

  @override
  void initState() {
    super.initState();
    html.window.onUnload.listen((event) async{
      print('Page is refreshed');
    });
  }

  Future checkLocationStatus() async{
    _serviceLocationEnabled = await location.serviceEnabled();
    if (!_serviceLocationEnabled) {
      _serviceLocationEnabled = await location.requestService();
      if (!_serviceLocationEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    //reverseGeocodingSearch(double.parse(_locationData.latitude.toString()) ,double.parse(_locationData.longitude.toString()));
    if(_locationData.latitude != null)
    {
      setState(() {
        _permissionLocation = true;
        print(_locationData);
      });
    }
    else
    {
      setState(() {
        _permissionLocation = false;
      });
    }
    
  }

  Future reverseGeocodingSearch(double lat, double long) async {
    var response = await googleGeocoding.geocoding.getReverse(LatLon(lat, long));
    print('Status: ${response?.status}');
    if (response != null && response.results != null) {
      if (mounted) {
        setState(() {
          reverseGeocodingResults = response.results!;
          print(reverseGeocodingResults);
        });
      }
    } else {
      if (mounted) {
        setState(() {
          reverseGeocodingResults = [];
          print('Error geocode: $reverseGeocodingResults');
        });
      }
    }
  }

  Future checkItemID() async{
    return _memoizer.runOnce(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await AuthenticationApplicationId().authAplicationId();
      isSignIn = prefs.getBool('UserAuth');
      await GetEntityList().fetchEntityList();
      String currentURL = Uri.base.toString();
      List<String> cutText = currentURL.split("/");
      route.AppRoutes.itemID = cutText[3];
      print('item id: ${route.AppRoutes.itemID}');
      bool exists = entityList.any((file) => file.rethinkpharmaceuticaldemoId == route.AppRoutes.itemID);
      print('ID Status: $exists');
      await checkLocationStatus();
      if(exists == true)
      {
        setState(() {
          print('id exist');
          urlIsValid = true;
          if (isSignIn == false || isSignIn == null)
          {
            print('User not sign in');
            QR.to('SignIn');
          }
          else
          {
            print('User already sign in');
            print(isSignIn);
          }
          LogsHandler().scannedActivityLogUpdate(
              'Scan QR code',
              route.AppRoutes.itemID,
              _locationData.latitude != null ? _locationData.latitude.toString(): 'Null', 
              _locationData.longitude != null ? _locationData.longitude.toString() : 'Null',
              'City',
              'State',
              'Malaysia',
              isSignIn!,
            );
        });
      }
      else if (exists == false)
      {
        setState(() {
          print('id not exist');
          urlIsValid = false;
        });
        LogsHandler().scannedActivityLogUpdate(
          'Scan QR code',
          'ID not valid',
          _locationData.latitude != null ? _locationData.latitude.toString(): 'Null', 
          _locationData.longitude != null ? _locationData.longitude.toString() : 'Null',
          'City',
          'State',
          'Malaysia',
          isSignIn!,
        );
      }
      return 'REMOTE DATA';
      }
    );
  } 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkItemID(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) 
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          return urlIsValid
          ? Scaffold(
            appBar: _permissionLocation 
            ?AppBar(
              title: const Text('Rethink Demo v1.7'),
              actions: <Widget>[
                IconButton(
                onPressed: () {
                  QR.to('UserProfile');
                }, 
                icon: const Icon(Icons.account_circle_rounded)
                ),
              ],
            )
            : null,
            body: _permissionLocation 
            ? Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Image.asset('images/WelcomePage.png'),
              ),
            )
            : const LocationDeniedScreen(),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Center(
                        child: Image.asset('images/Rethink Logo.png')
                      )
                    ),
                  ),
                  menuTile('Item Information', Icons.info_rounded , 'ItemInformation'),
                  MyTheme().subSeparator(),
                  menuTile('User Manual', Icons.help_rounded , 'UserManual'),
                  MyTheme().subSeparator(),
                  menuTile('Traceability', Icons.location_on_rounded ,'Traceability'),
                  MyTheme().subSeparator(),
                  menuTile('Augmented Reality', Icons.bubble_chart_rounded , route.AppRoutes.itemInformation),
                  MyTheme().subSeparator(),
                  menuTile('E-Store', Icons.store_rounded , route.AppRoutes.eStore),
                ],
              ),
            ),
          )
          : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
            ),
            body: const Center(
              child: Text('Something is wrong, you may enter wrong url')
            ),
          );
        }
      }
    );
  }

  ListTile menuTile(String title, IconData icon, String routeURL) {
    return ListTile(
      tileColor: Colors.blueGrey,
      leading: Icon( icon,
      color: Colors.white,
      ),
      title: Text(title,
      style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () {
        QR.to(routeURL);
      },
    );
  }
}