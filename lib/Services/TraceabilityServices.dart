// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rethink/System/Routes.dart' as route;
import 'package:rethink/Model/TraceabilityModel.dart';

List<dynamic> traceabilityList = [];

class GetTraceabilityInformation {
  String baseURL = 'https://netsecohauz.qliktag.com/api/v2/entity/rethinkpharmaceuticaldemo/';
  String itemID = route.MyRoutes.id;
  String authToken = '';

  

  // A function that converts a response body into a List<Photo>.
  Future fetchTraceabilityList() async {
    //await getAplicationIdAuth.AuthenticationApplicationId().authAplicationId();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('accessToken').toString();
    final response = await http
        .get(Uri.parse(baseURL + itemID),
        headers: <String, String>{
          'Authorization': 'Bearer ' + authToken,
          'Content-Type': 'application/json',
        },
      );

    if (response.statusCode == 200) {
      //print('Fetch entity success \n + Status code: ' + response.statusCode.toString() + '\n' + response.body);
      Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
      traceabilityList = data['data']['MapInfomation'];
      return TraceabilityModel.fromJson(jsonDecode(response.body));
    } 
    else {
      //print('Fetch tracaebility failed \n Status code: ' + response.statusCode.toString() + '\n' + response.body);
      throw Exception('Failed to load traceability list');
    }
  }
}