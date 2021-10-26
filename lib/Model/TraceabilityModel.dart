// To parse this JSON data, do
//
//     final traceabilityModel = traceabilityModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

TraceabilityModel traceabilityModelFromJson(String str) => TraceabilityModel.fromJson(json.decode(str));

String traceabilityModelToJson(TraceabilityModel data) => json.encode(data.toJson());

class TraceabilityModel {
    TraceabilityModel({
        required this.data,
    });

    Data data;

    factory TraceabilityModel.fromJson(Map<String, dynamic> json) => TraceabilityModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.mapInfomation,
    });

    List<MapInfomation> mapInfomation;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        mapInfomation: List<MapInfomation>.from(json["MapInfomation"].map((x) => MapInfomation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MapInfomation": List<dynamic>.from(mapInfomation.map((x) => x.toJson())),
    };
}

class MapInfomation {
    MapInfomation({
        required this.status,
        required this.latitude,
        required this.longitude,
        required this.locationName,
    });

    String status;
    String latitude;
    String longitude;
    String locationName;

    factory MapInfomation.fromJson(Map<String, dynamic> json) => MapInfomation(
        status: json["Status"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        locationName: json["LocationName"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "Latitude": latitude,
        "Longitude": longitude,
        "LocationName": locationName,
    };
}
