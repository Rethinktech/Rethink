// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  double itemInfoTitleFontSize = 12;
  double itemInfoSubtitleFontSize = 14;
  double itemInformationProductNameSize = 16;
  double itemInformationMiniNoteTextSize = 10;

  TextStyle itemInfoProductNameStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: itemInformationProductNameSize,
      color: Colors.black,
    );
  }

  TextStyle itemInfoTitleStyle() {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: itemInfoTitleFontSize,
      color: Colors.black,
    );
  }

  TextStyle itemInfoSubtitleStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: itemInfoSubtitleFontSize,
      color: Colors.black,
    );
  }
  TextStyle itemInfoSubtitleStyle2() {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: itemInfoSubtitleFontSize,
      color: Colors.black,
    );
  }

  TextStyle itemInfoMiniNoteTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: itemInformationMiniNoteTextSize,
      color: Colors.black,
    );
  }

  Container mainSeparator() {
    return Container(
      height: 20,
    );
  }

  Container subSeparator() {
    return Container(
      height: 3,
    );
  }

  BoxDecoration boxBorder() {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.black
      ),
      borderRadius: BorderRadius.circular(20
      ),
    );
  }
}