// To parse this JSON data, do
//
//     final authApplicationId = authApplicationIdFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AuthApplicationId authApplicationIdFromJson(String str) => AuthApplicationId.fromJson(json.decode(str));

String authApplicationIdToJson(AuthApplicationId data) => json.encode(data.toJson());

class AuthApplicationId {
    AuthApplicationId({
        required this.data,
    });

    Data data;

    factory AuthApplicationId.fromJson(Map<String, dynamic> json) => AuthApplicationId(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.applicationId,
        required this.accountUserId,
        required this.secretKey,
        required this.grantType,
    });

    String applicationId;
    String accountUserId;
    String secretKey;
    String grantType;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        applicationId: json["applicationId"] ?? "",
        accountUserId: json["accountUserId"] ?? "",
        secretKey: json["secretKey"] ?? "",
        grantType: json["grantType"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
        "accountUserId": accountUserId,
        "secretKey": secretKey,
        "grantType": grantType,
    };
}
