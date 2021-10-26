// To parse this JSON data, do
//
//     final itemInformationModel = itemInformationModelFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

ItemInformationModel itemInformationModelFromJson(String str) => ItemInformationModel.fromJson(json.decode(str));

String itemInformationModelToJson(ItemInformationModel data) => json.encode(data.toJson());

class ItemInformationModel {
    ItemInformationModel({
        required this.data,
    });

    Data data;

    factory ItemInformationModel.fromJson(Map<String, dynamic> json) => ItemInformationModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.productInformation,
    });

    ProductInformation productInformation;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        productInformation: ProductInformation.fromJson(json["ProductInformation"]),
    );

    Map<String, dynamic> toJson() => {
        "ProductInformation": productInformation.toJson(),
    };
}

class ProductInformation {
    ProductInformation({
        required this.productOwner,
        required this.expiryDate,
        required this.productName,
        required this.grossWeight,
        required this.indication,
        required this.batchNumber,
        required this.batchId,
        required this.productId,
        required this.medicalAuthorityLicense,
        required this.dosage,
        required this.netWeight,
        required this.thumbnail,
        required this.shortDescription,
        required this.storage,
        required this.gtinBarcode,
        required this.longDescription,
        required this.productRegistrationHolder,
        required this.price,
        required this.manufacturingDate,
        required this.caosuleContains,
        required this.manufacturer,
        required this.contains,
        required this.marketer,
        required this.sku,
    });

    Manufacturer productOwner;
    DateTime expiryDate;
    String productName;
    String grossWeight;
    Dosage indication;
    String batchNumber;
    String batchId;
    String productId;
    String medicalAuthorityLicense;
    Dosage dosage;
    String netWeight;
    Thumbnail thumbnail;
    Dosage shortDescription;
    Dosage storage;
    String gtinBarcode;
    Dosage longDescription;
    Manufacturer productRegistrationHolder;
    Price price;
    DateTime manufacturingDate;
    List<CaosuleContain> caosuleContains;
    Manufacturer manufacturer;
    String contains;
    List<String> marketer;
    String sku;

    factory ProductInformation.fromJson(Map<String, dynamic> json) => ProductInformation(
        productOwner: Manufacturer.fromJson(json["ProductOwner"]),
        expiryDate: DateTime.parse(json["ExpiryDate"]),
        productName: json["ProductName"],
        grossWeight: json["GrossWeight"],
        indication: Dosage.fromJson(json["Indication"]),
        batchNumber: json["BatchNumber"],
        batchId: json["BatchID"],
        productId: json["ProductID"],
        medicalAuthorityLicense: json["MedicalAuthorityLicense"],
        dosage: Dosage.fromJson(json["Dosage"]),
        netWeight: json["NetWeight"],
        thumbnail: Thumbnail.fromJson(json["Thumbnail"]),
        shortDescription: Dosage.fromJson(json["ShortDescription"]),
        storage: Dosage.fromJson(json["Storage"]),
        gtinBarcode: json["GTIN_Barcode"],
        longDescription: Dosage.fromJson(json["LongDescription"]),
        productRegistrationHolder: Manufacturer.fromJson(json["ProductRegistrationHolder"]),
        price: Price.fromJson(json["Price"]),
        manufacturingDate: DateTime.parse(json["ManufacturingDate"]),
        caosuleContains: List<CaosuleContain>.from(json["CaosuleContains"].map((x) => CaosuleContain.fromJson(x))),
        manufacturer: Manufacturer.fromJson(json["Manufacturer"]),
        contains: json["Contains"],
        marketer: List<String>.from(json["Marketer"].map((x) => x)),
        sku: json["SKU"],
    );

    Map<String, dynamic> toJson() => {
        "ProductOwner": productOwner.toJson(),
        "ExpiryDate": expiryDate.toIso8601String(),
        "ProductName": productName,
        "GrossWeight": grossWeight,
        "Indication": indication.toJson(),
        "BatchNumber": batchNumber,
        "BatchID": batchId,
        "ProductID": productId,
        "MedicalAuthorityLicense": medicalAuthorityLicense,
        "Dosage": dosage.toJson(),
        "NetWeight": netWeight,
        "Thumbnail": thumbnail.toJson(),
        "ShortDescription": shortDescription.toJson(),
        "Storage": storage.toJson(),
        "GTIN_Barcode": gtinBarcode,
        "LongDescription": longDescription.toJson(),
        "ProductRegistrationHolder": productRegistrationHolder.toJson(),
        "Price": price.toJson(),
        "ManufacturingDate": manufacturingDate.toIso8601String(),
        "CaosuleContains": List<dynamic>.from(caosuleContains.map((x) => x.toJson())),
        "Manufacturer": manufacturer.toJson(),
        "Contains": contains,
        "Marketer": List<dynamic>.from(marketer.map((x) => x)),
        "SKU": sku,
    };
}

class CaosuleContain {
    CaosuleContain({
        required this.stringAvp,
    });

    List<StringAvp> stringAvp;

    factory CaosuleContain.fromJson(Map<String, dynamic> json) => CaosuleContain(
        stringAvp: List<StringAvp>.from(json["stringAVP"].map((x) => StringAvp.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "stringAVP": List<dynamic>.from(stringAvp.map((x) => x.toJson())),
    };
}

class StringAvp {
    StringAvp({
        required this.name,
        required this.value,
    });

    String name;
    String value;

    factory StringAvp.fromJson(Map<String, dynamic> json) => StringAvp(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}

class Dosage {
    Dosage({
        required this.languageCode,
        required this.value,
    });

    String languageCode;
    String value;

    factory Dosage.fromJson(Map<String, dynamic> json) => Dosage(
        languageCode: json["languageCode"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "languageCode": languageCode,
        "value": value,
    };
}

class Manufacturer {
    Manufacturer({
        required this.address,
        required this.name,
    });

    String address;
    String name;

    factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
        address: json["Address"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Address": address,
        "Name": name,
    };
}

class Price {
    Price({
        required this.currency,
        required this.priceValue,
    });

    String currency;
    double priceValue;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        currency: json["Currency"],
        priceValue: json["PriceValue"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Currency": currency,
        "PriceValue": priceValue,
    };
}

class Thumbnail {
    Thumbnail({
        required this.languageCode,
        required this.type,
        required this.url,
    });

    List<String> languageCode;
    String type;
    String url;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        languageCode: List<String>.from(json["languageCode"].map((x) => x)),
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "languageCode": List<dynamic>.from(languageCode.map((x) => x)),
        "type": type,
        "url": url,
    };
}
