// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rethink/System/Routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:rethink/System/Theme.dart';
import 'package:rethink/main.dart' as main;

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  
  const HomeScreen({ Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return main.urlisValid
    ? Scaffold(
      appBar: AppBar(
        title: const Text('Rethink Demo'),
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
            menuTile('Item Information', Icons.info_rounded , MyRoutes.itemInformationRoute),
            MyTheme().subSeparator(),
            menuTile('User Manual', Icons.help_rounded , MyRoutes.userManualRoute),
            MyTheme().subSeparator(),
            menuTile('Traceability', Icons.location_on_rounded , MyRoutes.traceabilityRoute),
            MyTheme().subSeparator(),
            menuTile('Augmented Reality', Icons.bubble_chart_rounded , MyRoutes.itemInformationRoute),
            MyTheme().subSeparator(),
            menuTile('E-Store', Icons.store_rounded , MyRoutes.itemInformationRoute),
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

  ListTile menuTile(String title, IconData icon, String route) {
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
        Navigator.pop(context);
        context.vxNav.push(Uri.parse(route));
      },
    );
  }
}