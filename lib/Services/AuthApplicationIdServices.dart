// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rethink/Model/AuthApplicationIdModel.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthenticationApplicationId {

  String authURL = 'https://netsecohauz.qliktag.com/api/v2/oauth';
  String applicationId = '4b0d3950-9cdf-11eb-9dcf-c3bb3b1e4673';
  String accountUserId = '4b0941b0-9cdf-11eb-9dcf-c3bb3b1e4673';
  String secretkey = '1e4ff469-57f7-4caf-8b8d-a3d4557bb05a';
  String grantType = 'applicationId';

  Future<AuthApplicationId> authAplicationId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(authURL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: utf8.encode(
        jsonEncode(<String, dynamic>{
          "data": {
            "applicationId": applicationId,
            "accountUserId": accountUserId,
            "secretKey": secretkey,
            "grantType": grantType
          }
        }
      )),
    );

    if (response.statusCode == 200) {
      //print(response.headers.entries);
      //print('Authentication Aplication ID success \n' + 'Status code: ' + response.statusCode.toString() + '\n' + response.body);
      Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
      String accessToken = data['data']['accessToken'];
      //print(accessToken);
      await prefs.setString('accessToken', accessToken);
      

      return AuthApplicationId.fromJson(jsonDecode(response.body));
    } 
    else {
      //print('Failed to authenticate aplication ID \n' + 'Status code: ' + response.statusCode.toString() + '\n' + response.body);
      throw Exception('Failed to authenticate.');
    }
  }
}