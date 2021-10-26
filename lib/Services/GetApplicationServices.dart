// ignore_for_file: file_names

import 'package:http/http.dart' as http;

class GetApplication {
  String applicationURL = 'https://netsecohauz.qliktag.com/api/v2/application';
  String authToken = 'Bearer e98b012a-ccb8-4bd8-8cf4-30cc45b34b38';

  // A function that converts a response body into a List<Photo>.
  Future fetchApplication() async {
    final response = await http
        .get(Uri.parse(applicationURL),
        headers: <String, String>{
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      );

    if (response.statusCode == 200) {
      print('Fetch application success \n' + 'Status code: ' + response.statusCode.toString() + '\n' + response.body);
      //return EntityList.fromJson(jsonDecode(response.body));
    } 
    else {
      print('Fetch application failed \n' + 'Status code: ' + response.statusCode.toString() + '\n' + response.body);
      //throw Exception('Failed to load album');
    }
  }
}