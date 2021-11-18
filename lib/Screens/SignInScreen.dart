// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rethink/Screens/HomeScreen.dart' as homeScreen;
import 'package:rethink/Model/user.dart' as user;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rethink/Handler/UserAccountHandler.dart';
import 'package:rethink/System/Theme.dart';
import 'package:rethink/System/AppRoutes.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final firestoreInstance = FirebaseFirestore.instance;
  GoogleSignInAccount? currentUser;

  @override
  void initState() {
    googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> handleGoogleSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await googleSignIn.signIn();
      if(googleSignIn.currentUser != null)
      {
        currentUser = googleSignIn.currentUser;
        await createUser();
        await prefs.setBool('UserAuth', true);
        await prefs.setString('UserID', currentUser!.id);
        setState(() {
          print(currentUser);
          QR.to(AppRoutes.itemID);
        });
      }
    } catch (error) {
      print(error);
    }
  }

Future<void> handleGoogleSignOut() async {
  print('handle sign out');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await googleSignIn.signOut();
      if(googleSignIn.currentUser == null)
      {
        currentUser = null;
        await prefs.setBool('UserAuth', false);
        await prefs.clear();
        QR.to('SignIn');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<bool> checkIfDocExists(String? docId) async {
  try {
    var collectionRef = firestoreInstance.collection('usersprofile');

    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
}

  Future createUser() async{
    bool docExists = await checkIfDocExists(currentUser?.id);
    print("Document exists in Firestore? " + docExists.toString());
    if(docExists == false)
    {
      firestoreInstance.collection("usersprofile").doc(currentUser?.id).set(
      {
        "username": currentUser?.displayName,
        "userid": currentUser?.id,
        "photourl": currentUser?.photoUrl,
        "email": currentUser?.email,
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
        user.User.id = currentUser?.id;
        user.User.username = currentUser?.displayName;
        user.User.email = currentUser?.email;
        user.User.photourl = currentUser?.photoUrl;
        print('Account created');
      });
    }
    else{
      print('Account already exist');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign In'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 100,
          ),
          SizedBox(
            height: 100,
            child: Image.network('images/Rethink Logo.png'
            ),
          ),
          MyTheme().mainSeparator(),
          Container(
            alignment: Alignment.center,
            child: const Text('Sign In with your social account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          MyTheme().mainSeparator(),
          Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            height: 1,
            child: Container(
              color: Colors.black,
            ),
          ),
          MyTheme().mainSeparator(),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                handleGoogleSignIn();
              }, 
              child: Image.asset('images/sign-in-with-google-icon-3.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}