// ignore_for_file: file_names

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rethink/System/AppRoutes.dart';
import 'package:rethink/System/Theme.dart';
import 'package:rethink/Model/user.dart' as user;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qlevar_router/qlevar_router.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({ Key? key }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  bool editPhoneNumber = false;
  bool editAddress = false;
  bool onChange = false;
  
  TextEditingController phoneNumberController = TextEditingController();
  bool _phoneNumberValidate = true;
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressCountryController = TextEditingController();
  TextEditingController addressZipCodeController = TextEditingController();
  bool _addressLine1Validate = true;
  bool _addressLine2Validate = true;
  bool _addressCityValidate = true;
  bool _addressStateValidate = true;
  bool _addressCountryValidate = true;
  bool _addressZipCodeValidate = true;

  String id = '';
  String username = '';
  String email = '';
  String photourl = '';
  String phoneNumber = '';
  String countryCode = '+60';
  String addressline1 = '';
  String addressline2 = '';
  String city = '';
  String country = '';
  String state = '';
  String zipcode = '';

  Future getUserProfileData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('UserID').toString();
    return firestoreInstance.collection("usersprofile").doc(id).get().then((value){
      print(value.data());
      username = value.data()!["username"];
      email = value.data()!["email"];
      photourl = value.data()!["photourl"];
      phoneNumber = value.data()!["phonenumber"];
      addressline1 = value.data()!["address"]["addressline1"];
      addressline2 = value.data()!["address"]["addressline2"];
      city = value.data()!["address"]["city"];
      country = value.data()!["address"]["country"];
      state = value.data()!["address"]["state"];
      zipcode = value.data()!["address"]["zipcode"];
      return 'Done';
    });
  }

  Future submitPhoneNumberChanges() {
    return firestoreInstance
        .collection("usersprofile")
        .doc(id)
        .update({
          "phonenumber": phoneNumberController.text != ''
                       ? phoneNumberController.text
                       : phoneNumber,
      }).then((_) {
      setState(() {
        editPhoneNumber = false;
        print("success!");
      });
    });
  }

  Future submitAddressChanges() {
    return firestoreInstance
        .collection("usersprofile")
        .doc(id)
        .update({
          "address.addressline1": addressLine1Controller.text != ''
                                ? addressLine1Controller.text
                                : addressline1,
          "address.addressline2": addressLine2Controller.text != ''
                                ? addressLine2Controller.text
                                : addressline2,
          "address.city": addressCityController.text != ''
                        ? addressCityController.text
                        : city,
          "address.country": addressCountryController.text != ''
                           ? addressCountryController.text
                           : country,
          "address.state": addressStateController.text != ''
                         ? addressStateController.text
                         : state,
          "address.zipcode": addressZipCodeController.text != ''
                           ? addressZipCodeController.text
                           : zipcode,
        }).then((_) {
      setState(() {
        editAddress = false;
        print("success!");
      });
    });
  }

  Future submitChangeHandler() async{
    setState(() {
      onChange = true;
    });
    // Check phone number field
    if(phoneNumberController.text != '')
    {
      _phoneNumberValidate = true;
    }
    else
    {
      if(phoneNumber == '')
      {
        _phoneNumberValidate = false;
      }
      else
      {
        _phoneNumberValidate = true;
      }
    }
    // Check address line 1 field
    if(addressLine1Controller.text != '')
    {
      _addressLine1Validate = true;
    }
    else
    {
      if(addressline1 == '')
      {
        _addressLine1Validate = false;
      }
      else
      {
        _addressLine1Validate = true;
      }
    }
    // Check address line 2 field
    if(addressLine2Controller.text != '')
    {
      _addressLine2Validate = true;
    }
    else 
    {
      if (addressline2 == '')
      {
        _addressLine2Validate = false;
      }
      else
      {
        _addressLine2Validate = true;
      }
    }
    // Check address city field
    if(addressCityController.text != '')
    {
      _addressCityValidate = true;
    }
    else 
    {
      if(city == '')
      {
        _addressCityValidate = false;
      }
      else 
      {
        _addressCityValidate = true;
      }
    }
    // Check address state field
    if(addressStateController.text != '')
    {
      _addressStateValidate = true;
    }
    else 
    {
      if (state == '')
      {
        _addressStateValidate = false;
      }
      else 
      {
        _addressStateValidate = true;
      }
    }
    // Check address country field
    if(addressCountryController.text != '')
    {
      _addressCountryValidate = true;
    }
    else 
    {
      if (country == '')
      {
        _addressCountryValidate = false;
      }
      else 
      {
        _addressCountryValidate = true;
      }
    }
    // Check address zipcode field
    if(addressZipCodeController.text != '')
    {
      _addressZipCodeValidate = true;
    }
    else 
    {
      if (zipcode == '')
      {
        _addressZipCodeValidate = false;
      }
      else 
      {
        _addressZipCodeValidate = true;
      }
    }
    if (_phoneNumberValidate == true)
    {
      await submitPhoneNumberChanges();
    }
    if(_addressLine1Validate == true &&
       _addressCityValidate == true &&
       _addressStateValidate == true &&
       _addressCountryValidate == true &&
       _addressZipCodeValidate == true)
    {
      await submitAddressChanges();
    }
    setState(() {
      onChange = false;
    });
    return 'Success';
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
        QR.to('SignIn');
      }
    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserProfileData(),
      builder: (BuildContext context, snapshot) {
        if(!snapshot.hasData)
        {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              leading: IconButton(
                onPressed: () {
                  QR.to(AppRoutes.itemID);
                }, 
              icon: const Icon(Icons.arrow_back_rounded)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  MyTheme().mainSeparator(),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(photourl),
                    ),
                  ),
                  MyTheme().mainSeparator(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username',
                        style: MyTheme().itemInfoSubtitleStyle(),
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: username
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                  MyTheme().mainSeparator(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User ID',
                        style: MyTheme().itemInfoSubtitleStyle(),
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: id
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                  MyTheme().mainSeparator(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',
                        style: MyTheme().itemInfoSubtitleStyle(),
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: email
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                  MyTheme().mainSeparator(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone Number',
                        style: MyTheme().itemInfoSubtitleStyle(),
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            margin: const EdgeInsets.only(right: 10),
                            child: TextFormField(
                              enabled: editPhoneNumber,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: countryCode,
                                errorText: _phoneNumberValidate ? null : '',
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: phoneNumberController,
                              enabled: editPhoneNumber,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: phoneNumber,
                                hintText: 'Your phone number',
                                errorText: _phoneNumberValidate ? null : 'Phone number cannot empty',
                              ),
                            ),
                          ),
                          IconButton(
                            splashRadius: 15,
                            onPressed: () {
                              setState(() {
                                editPhoneNumber = true;
                              });
                            }, 
                            icon: Icon(Icons.edit_rounded,
                            color: editPhoneNumber
                            ? Colors.blue
                            : Colors.black,
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                  MyTheme().mainSeparator(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address',
                        style: MyTheme().itemInfoSubtitleStyle(),
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressLine1Controller,
                              enabled: editAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: addressline1 != ''
                                ? addressline1
                                : 'Address line 1',
                                hintText: '',
                                errorText: _addressLine1Validate 
                                ? null
                                : 'Please enter your address line 1',
                              ),
                            ),
                          ),
                          IconButton(
                            splashRadius: 15,
                            onPressed: () {
                              setState(() {
                                editAddress = true;
                              });
                            }, 
                            icon: Icon(Icons.edit_rounded,
                            color: editAddress
                            ? Colors.blue
                            : Colors.black,
                            )
                          ),
                        ],
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressLine2Controller,
                              enabled: editAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: addressline2  != ''
                                ? addressline2
                                : 'Address line 2 (Optional)',
                                hintText: 'Address line 1 (Optional)',
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressCityController,
                              enabled: editAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: city != ''
                                ? city
                                : 'City',
                                hintText: 'City',
                                errorText: _addressCityValidate
                                ? null
                                : "Please enter your city",
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressStateController,
                              enabled: editAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: state != ''
                                ? state
                                : 'State',
                                hintText: 'State',
                                errorText: _addressStateValidate
                                ? null
                                : 'Please enter your state',
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressCountryController,
                              enabled: editAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: country != ''
                                ? country
                                : 'Country',
                                hintText: 'Country',
                                errorText: _addressCountryValidate
                                ? null
                                : 'Please enter your country',
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                      MyTheme().subSeparator(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressZipCodeController,
                              enabled: editAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: MyTheme().itemInfoSubtitleStyle2(),
                                labelText: zipcode != ''
                                ? zipcode
                                : 'Zip Code',
                                hintText: 'Zip Code',
                                errorText: _addressZipCodeValidate 
                                ? null
                                : 'Please enter your zip code'
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                  MyTheme().mainSeparator(),
                  if (editPhoneNumber == true || editAddress == true)
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
                    margin: const EdgeInsets.only(right: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          submitChangeHandler();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green
                      ),
                      child: onChange
                      ? const SizedBox(height: 8, width: 8, child: CircularProgressIndicator())
                      : const Text('Save'),
                    ),
                  ),
                  MyTheme().mainSeparator(),
                  MyTheme().mainSeparator(),
                  Container(
                    //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.5),
                    margin: const EdgeInsets.only(right: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          handleGoogleSignOut();
                        });
                      },
                      child: const Text('Sign Out'),
                    ),
                  ),
                ],
              ),
            ),
          );
      }
    );
  }
}