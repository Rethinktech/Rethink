// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rethink/Services/AuthApplicationIdServices.dart';
import 'package:rethink/System/Routes.dart' as route;
import 'package:velocity_x/velocity_x.dart';
import 'package:rethink/main.dart' as main;

class SplahScreen extends StatefulWidget {
  const SplahScreen({ Key? key }) : super(key: key);

  @override
  SplahScreenState createState() => SplahScreenState();
}

class SplahScreenState extends State<SplahScreen> {


  void getQliktagAuth() async{
    await AuthenticationApplicationId().authAplicationId();
    route.MyRoutes.id = 'abc124';
    print(route.MyRoutes.id);
    print(route.MyRoutes.homePageRoute);
    if(route.MyRoutes.id != '')
    {
      print('success: id found ${route.MyRoutes.id}');
      context.vxNav.push(Uri.parse(route.MyRoutes.homePageRoute));
      print('Navigate to home page');
    }
    else
    {
      print('Error: id not found ${route.MyRoutes.id}');
    }
    
  }

  @override
  void initState() {
    super.initState();
    getQliktagAuth();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
