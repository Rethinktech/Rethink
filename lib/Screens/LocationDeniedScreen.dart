// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:rethink/System/Theme.dart';
import 'package:location/location.dart' as loc;

class LocationDeniedScreen extends StatefulWidget {
  const LocationDeniedScreen({ Key? key }) : super(key: key);

  @override
  _LocationDeniedScreenState createState() => _LocationDeniedScreenState();
}

class _LocationDeniedScreenState extends State<LocationDeniedScreen> {

  loc.Location location = loc.Location();
  late bool _serviceLocationEnabled;
  bool _permissionLocation = false;
  late  loc.PermissionStatus _permissionGranted;
  late  loc.LocationData _locationData;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTheme().mainSeparator(),
            const Text('Please allow Rethinktech to access your device location'),
            MyTheme().mainSeparator(),
            const Text('Click refresh button page below to refresh after you allowing access location'),
            MyTheme().mainSeparator(),
            ElevatedButton(
              onPressed: () {
                String currentPath = Uri.base.toString();
                QR.to(currentPath);
              },
              child: const Text('Refresh Page')
            )
          ],
        ),
      ),
    );
  }
}