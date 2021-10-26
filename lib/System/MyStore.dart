// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:vxstate/vxstate.dart';

// Build store and make it part of app
void main() {
  runApp(VxState(
    store: MyStore(),
    child: MyApp(),
  ));
}

// Store definition
class MyStore extends VxStore {
  int count = 0;
}

// Mutations
class Increment extends VxMutation<MyStore> {
  perform() => store?.count++;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define when this widget should re render
    VxState.store (context, to: [Increment]);

    // Get access to the store
    MyStore store = VxState.store;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Text("Count: ${store.count}"),
            RaisedButton(
              child: Text("Increment"),
              onPressed: () {
                // Invoke mutation
                Increment();
              },
            ),
          ],
        ),
      ),
    );
  }
}
