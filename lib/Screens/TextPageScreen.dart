// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TextPage extends StatelessWidget {

  final String text;
  final List<Widget>? extra;
  TextPage(this.text, {this.extra});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Text(text)),
          Center(child: TextButton(onPressed: QR.back, child: const Text('Back'))),
        ]..addAll(extra ?? []),
      ),
    );
  }
}