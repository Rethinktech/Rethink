// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rethink/Services/AuthApplicationIdServices.dart';
import 'package:rethink/System/Routes.dart' as route;
import 'package:velocity_x/velocity_x.dart';
import 'package:rethink/main.dart' as main;
import 'package:rethink/Services/GetEntityListServices.dart'; 
import 'package:rethink/System/Routes.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({ Key? key }) : super(key: key);

  @override
  SplahScreenState createState() => SplahScreenState();
}

class SplahScreenState extends State<SplahScreen> {

  bool checkUrl = false;
  bool urlisValid = false;

  Future getQliktagAuth() async{
    await AuthenticationApplicationId().authAplicationId();
    await GetEntityList().fetchEntityList();
    String currentURL = Uri.base.toString();
    List<String> cutText = currentURL.split("/");
    route.MyRoutes.id = cutText[3];
    bool exists = entityList.any((file) => file.rethinkpharmaceuticaldemoId == route.MyRoutes.id);
    if(exists == true)
    {
      QR.to(route.MyRoutes.id);
      urlisValid = true;
    }
    else if (exists == false)
    {
      QR.to('404');
      urlisValid = false;
    }
    
  }

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration.zero,()async {
    await getQliktagAuth();
     if (checkUrl == false)
      {
        
        checkUrl = true;
      }
   });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
