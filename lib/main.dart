import 'package:flutter/material.dart';
import 'package:rethink/Screens/HomeScreen.dart';
import 'package:rethink/System/Routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vxstate/vxstate.dart';
import 'package:rethink/Screens/ItemInfoScreen.dart';
import 'package:rethink/Screens/UserManualScreen.dart';
import 'package:rethink/Screens/TraceabilityScreen.dart';
import 'package:rethink/System/Routes.dart' as route;
import 'package:rethink/Services/AuthApplicationIdServices.dart';
import 'package:rethink/Services/GetEntityListServices.dart';

bool urlisValid = true;

Future getQliktagAuth() async{
    await AuthenticationApplicationId().authAplicationId();
    await GetEntityList().fetchEntityList();
    String currentURL = Uri.base.toString();
    List<String> cutText = currentURL.split("/");
    route.MyRoutes.id = cutText[3];
    bool exists = entityList.any((file) => file.rethinkpharmaceuticaldemoId == route.MyRoutes.id);
    if(exists == true)
    {
      urlisValid = true;
    }
    else if (exists == false)
    {
      urlisValid = false;
    }
    
  }
  

void main() {
  setPathUrlStrategy();
  //await getQliktagAuth();
  runApp(VxState(store: MyRethink(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
      ),
      routeInformationParser: VxInformationParser(), 
      routerDelegate: VxNavigator(
        routes: {
          "/": (_, __) => const MaterialPage(child: HomeScreen()),
          MyRoutes.homePageRoute: (_ ,__) => const MaterialPage(child: HomeScreen()),
          MyRoutes.itemInformationRoute: (_, __) => const MaterialPage(child: ItemInfoScreen()),
          MyRoutes.userManualRoute: (_, __) => const MaterialPage(child: UserManual()),
          MyRoutes.traceabilityRoute: (_, __) => const MaterialPage(child: TraceabilityScreen()),
        },
      ),
    );
  }
}

class MyRethink extends VxStore {
  
}