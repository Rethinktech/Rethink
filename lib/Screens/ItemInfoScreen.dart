// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rethink/System/Theme.dart';
import 'package:rethink/Services/ItemInformationServices.dart' as itemInfoServices;

class ItemInfoScreen extends StatefulWidget {
  const ItemInfoScreen({Key? key}) : super(key: key);


  @override
  _ItemInfoScreenState createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemInfoServices.GetItemInformaionList().fetchItemInformationList(),
      builder: (BuildContext contex, snapshot) {
        if(snapshot.hasData)
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product Information')
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: MyTheme().boxBorder(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              width: 300,
                              height: 300,
                              child: Image.network(itemInfoServices.imageURL),
                            ),
                            MyTheme().mainSeparator(),
                          ],
                        ),
                        Text('Product Name',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.productName,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Brand',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.brandname,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Product Owner',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.productOwnerName,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        Text(itemInfoServices.productOwnerAddress,
                          style: MyTheme().itemInfoSubtitleStyle2(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Marketer',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.marketerName1,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        Text(itemInfoServices.marketerName2,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Manufacturer',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.manufacturerName,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        Text(itemInfoServices.manufacturerAddress,
                          style: MyTheme().itemInfoSubtitleStyle2(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Product Registration Holder',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.productRegHolderName,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        Text(itemInfoServices.productRegHolderAddress,
                          style: MyTheme().itemInfoSubtitleStyle2(),
                        ),
                        MyTheme().mainSeparator(),
                      ],
                    ),
                  ),
                  MyTheme().mainSeparator(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: MyTheme().boxBorder(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyTheme().mainSeparator(),
                        Text('Price',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Row(
                          children: [
                            Text(itemInfoServices.currency,
                              style: MyTheme().itemInfoSubtitleStyle(),
                            ),
                            Container(
                              width: 5,
                            ),
                            Text(itemInfoServices.price.toString(),
                              style: MyTheme().itemInfoSubtitleStyle(),
                            ),
                          ],
                        ),
                        MyTheme().mainSeparator(),
                        Text('Short Description',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.shortDescription,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Long Description',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.longDescription,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Contains',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.contains,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Gross Weight',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.grossWeight,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Net Weight',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.netWeight,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Manufacturing Date',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.manufacturingDate,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Expiry Date',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.expiryDate,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Capsule Contains',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(itemInfoServices.capsuleContainsName1,
                                style: MyTheme().itemInfoSubtitleStyle(),
                              ),
                            ),
                            Expanded(
                              child: Text(itemInfoServices.capsuleContainsValue1,
                              style: MyTheme().itemInfoSubtitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(itemInfoServices.capsuleContainsName2,
                                style: MyTheme().itemInfoSubtitleStyle(),
                              ),
                            ),
                            Expanded(
                              child: Text(itemInfoServices.capsuleContainsValue2,
                              style: MyTheme().itemInfoSubtitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(itemInfoServices.capsuleContainsName3,
                                style: MyTheme().itemInfoSubtitleStyle(),
                              ),
                            ),
                            Expanded(
                              child: Text(itemInfoServices.capsuleContainsValue3,
                              style: MyTheme().itemInfoSubtitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(itemInfoServices.capsuleContainsName4,
                                style: MyTheme().itemInfoMiniNoteTextStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(itemInfoServices.capsuleContainsName5,
                                style: MyTheme().itemInfoMiniNoteTextStyle(),
                              ),
                            ),
                          ],
                        ),
                        MyTheme().mainSeparator(),
                        Text('Indication',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.indication,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Dosage',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.dosage,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Storage',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.storage,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                      ],
                    ),
                  ),
                  MyTheme().mainSeparator(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: MyTheme().boxBorder(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyTheme().mainSeparator(),
                        Text('Product ID',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.productID,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('SKU',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.sku,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('GTIN/Barcode',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.gtin,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Batch ID',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.batchID,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Batch Number',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.batchNumber,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                        Text('Medical Authority License',
                          style: MyTheme().itemInfoTitleStyle(),
                        ),
                        MyTheme().subSeparator(),
                        Text(itemInfoServices.medicalAuthorityLicense,
                          style: MyTheme().itemInfoSubtitleStyle(),
                        ),
                        MyTheme().mainSeparator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}