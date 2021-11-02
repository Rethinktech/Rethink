// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rethink/System/Routes.dart';
import 'package:rethink/Model/ItemInformationModel.dart';
import 'package:rethink/Services/AuthApplicationIdServices.dart';
import 'package:rethink/System/AppRoutes.dart' as route;

List<ItemInformationModel> itemInfoList = [];
String imageURL = '';
String brandname = '';
String productName = '';
String productOwnerName = '';
String productOwnerAddress = '';
String productRegHolderName = '';
String productRegHolderAddress = '';
String manufacturerName = '';
String manufacturerAddress = '';
String marketerName1 = '';
String marketerName2 = '';
////////////////////////////////////////
String currency = '';
double price = 0;
String shortDescription = '';
String longDescription = '';
String contains = '';
String grossWeight = '';
String netWeight = '';
String manufacturingDate = '';
String expiryDate = '';
String capsuleContainsName1 = '';
String capsuleContainsName2 = '';
String capsuleContainsName3 = '';
String capsuleContainsName4 = '';
String capsuleContainsName5 = '';
String capsuleContainsValue1 = '';
String capsuleContainsValue2 = '';
String capsuleContainsValue3 = '';
String capsuleContainsValue4 = '';
String capsuleContainsValue5 = '';
String indication = '';
String dosage = '';
String storage = '';
////////////////////////////////////////
String productID = '';
String sku = '';
String gtin = '';
String batchID = '';
String batchNumber = '';
String medicalAuthorityLicense = '';
////////////////////////////////////////

class GetItemInformaionList {
  String baseURL = 'https://netsecohauz.qliktag.com/api/v2/entity/rethinkpharmaceuticaldemo/';
  String itemID = route.id;
  String authToken = '';
  
  // A function that converts a response body into a List<Photo>.
  Future fetchItemInformationList() async {
    await AuthenticationApplicationId().authAplicationId();
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
      //print('Fetch item information success \n Status code: ' + response.statusCode.toString() + '\n' + response.body);
      Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
      imageURL = data['data']['ProductInformation']['Thumbnail']['url'];
      brandname = data['data']['BrandInformation']['BrandName'];
      productName = data['data']['ProductInformation']['ProductName'];
      productOwnerName = data['data']['ProductInformation']['ProductOwner']['Name'];
      productOwnerAddress = data['data']['ProductInformation']['ProductOwner']['Address'];
      marketerName1 = data['data']['ProductInformation']['Marketer'][0];
      marketerName2 = data['data']['ProductInformation']['Marketer'][1];
      manufacturerName = data['data']['ProductInformation']['Manufacturer']['Name'];
      manufacturerAddress = data['data']['ProductInformation']['Manufacturer']['Address'];
      productRegHolderName = data['data']['ProductInformation']['ProductRegistrationHolder']['Name'];
      productRegHolderAddress = data['data']['ProductInformation']['ProductRegistrationHolder']['Address'];
      ////////////////////////////////////////
      currency = data['data']['ProductInformation']['Price']['Currency'];
      price = data['data']['ProductInformation']['Price']['PriceValue'];
      shortDescription = data['data']['ProductInformation']['ShortDescription']['value'];
      longDescription = data['data']['ProductInformation']['LongDescription']['value'];
      contains = data['data']['ProductInformation']['Contains'];
      grossWeight = data['data']['ProductInformation']['GrossWeight'];
      netWeight = data['data']['ProductInformation']['NetWeight'];
      manufacturingDate = data['data']['ProductInformation']['ManufacturingDate'];
      expiryDate = data['data']['ProductInformation']['ExpiryDate'];
      capsuleContainsName1 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][0]['value'];
      capsuleContainsName2 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][1]['value'];
      capsuleContainsName3 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][2]['value'];
      capsuleContainsName4 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][3]['value'];
      capsuleContainsName5 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][4]['value'];
      capsuleContainsValue1 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][0]['name'];
      capsuleContainsValue2 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][1]['name'];
      capsuleContainsValue3 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][2]['name'];
      capsuleContainsValue4 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][3]['name'];
      capsuleContainsValue5 = data['data']['ProductInformation']['CaosuleContains'][0]['stringAVP'][4]['name'];
      indication = data['data']['ProductInformation']['Indication']['value'];
      dosage = data['data']['ProductInformation']['Dosage']['value'];
      storage = data['data']['ProductInformation']['Storage']['value'];
      ////////////////////////////////////////
      productID = data['data']['ProductInformation']['ProductID'];
      sku = data['data']['ProductInformation']['SKU'];
      gtin = data['data']['ProductInformation']['GTIN_Barcode'];
      batchID = data['data']['ProductInformation']['BatchID'];
      batchNumber = data['data']['ProductInformation']['BatchNumber'];
      medicalAuthorityLicense = data['data']['ProductInformation']['MedicalAuthorityLicense'];
      return ItemInformationModel.fromJson(jsonDecode(response.body));
    } 
    else {
      print('Fetch item information failed \n Status code: ' + response.statusCode.toString() + '\n' + response.body);
      throw Exception('Failed to load item information');
    }
  }
}