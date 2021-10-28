// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rethink/Model/EntityList.dart';
import 'package:rethink/Model/EntityListModel.dart';
import 'package:rethink/Services/AuthApplicationIdServices.dart';

List<dynamic> entityList = [];

class GetEntityList {
  String entityURL = 'https://netsecohauz.qliktag.com/api/v2/entity/rethinkpharmaceuticaldemo';
  String authToken = '';

  

  // A function that converts a response body into a List<Photo>.
  Future fetchEntityList() async {
    await AuthenticationApplicationId().authAplicationId();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('accessToken').toString();
    final response = await http
        .get(Uri.parse(entityURL),
        headers: <String, String>{
          'Authorization': 'Bearer ' + authToken,
          'Content-Type': 'application/json',
        },
      );

    if (response.statusCode == 200) {
      //print('Fetch entity success \n + Status code: ' + response.statusCode.toString() + '\n' + response.body);
      entityList = json.decode(response.body)['data']['rethinkpharmaceuticaldemo']
      .map((data) => EntityListModel.fromJson(data)).toList();

      return EntityList.fromJson(jsonDecode(response.body));
    } 
    else {
      //print('Fetch entity failed \n Status code: ' + response.statusCode.toString() + '\n' + response.body);
      throw Exception('Failed to load entity list');
    }
  }
}