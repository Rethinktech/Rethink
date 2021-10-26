// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rethink/Model/Authentication.dart';



class Authentication {
  String authURL = 'https://netsecohauz.qliktag.com/api/v2/oauth';
  String email = 'alex.restore@netsgroup.com.my';
  String password = 'My263202@';
  String grantType = 'password';
  String authToken = 'Bearer 3fdde4f5-83d9-4e11-b931-c22e40f6e7b9';

  Future<GetAuthentication> auth() async {
    final response = await http.post(
      Uri.parse(authURL),
      headers: <String, String>{
        'Authorization': authToken,
        'Content-Type': 'application/json',
      },
      body: utf8.encode(
        jsonEncode(<String, dynamic>{
          'data': {
            'email': email,
            'password': password,
            'grantType': grantType,
          },
        }
      )),
    );

    if (response.statusCode == 200) {
      print('Authentication success \n' + 'Status code: ' + response.statusCode.toString() + '\n' + response.body);
      return GetAuthentication.fromJson(jsonDecode(response.body));
    } 
    else {
      print('Failed to authenticate \n' + 'Status code: ' + response.statusCode.toString() + '\n' + response.body);
      throw Exception('Failed to authenticate.');
    }
  }
}