// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rethink/Screens/SignInScreen.dart';

class UserAccountHandler {
  final firestoreInstance = FirebaseFirestore.instance;
  
  Future createUser() async{
    firestoreInstance.collection("usersprofile").doc(SignInScreenState().googleSignIn.currentUser?.id).set(
    {
      "username": SignInScreenState().googleSignIn.currentUser?.displayName,
      "userid": SignInScreenState().googleSignIn.currentUser?.id,
      "photourl": SignInScreenState().googleSignIn.currentUser?.photoUrl,
      "email": SignInScreenState().googleSignIn.currentUser?.email,
      "phonenumber": "",
      "address": {
        "addressline1": "",
        "addressline2": "",
        "city": "",
        "state": "",
        "zipcode": "",
        "country": "",
      }
    }).then((value){
      print('Account created');
    });
  }
}