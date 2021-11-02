// ignore_for_file: file_names

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:rethink/Services/AuthApplicationIdServices.dart';
import 'package:rethink/Services/GetEntityListServices.dart';
import 'package:rethink/System/Routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:rethink/System/Theme.dart';
import 'package:rethink/main.dart' as main;
import 'package:rethink/Screens/SignInScreen.dart';
import 'package:rethink/System/AppRoutes.dart' as route;
import 'package:qlevar_router/qlevar_router.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  
  const HomeScreen({ Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  bool isSignIn = true;
  bool urlIsValid = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
     if (isSignIn == false)
      {
        Navigator.pop(context);
          context.vxNav.push(Uri.parse(MyRoutes.signInRoute));
      }
   });
  }

  Future getQliktagAuth() async{
    return _memoizer.runOnce(() async {
    await AuthenticationApplicationId().authAplicationId();
    await GetEntityList().fetchEntityList();
    String currentURL = Uri.base.toString();
    List<String> cutText = currentURL.split("/");
    route.id = cutText[3];
    print('item id: ${route.id}');
    bool exists = entityList.any((file) => file.rethinkpharmaceuticaldemoId == route.id);
    print('ID Status: $exists');
    if(exists == true)
    {
      setState(() {
        print('id exist');
        urlIsValid = true;
      });
    }
    else if (exists == false)
    {
      setState(() {
        print('id not exist');
        urlIsValid = false;
      });
    }
    return 'REMOTE DATA';
    });
  } 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getQliktagAuth(),
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
            appBar: AppBar(
              title: const Text('Rethink Demo v1.4'),
            ),
            body: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Image.asset('images/WelcomePage.png'),
              ),
            ),
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