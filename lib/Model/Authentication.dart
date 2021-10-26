// To parse this JSON data, do
//
//     final getAuthentication = getAuthenticationFromJson(jsonString);

import 'dart:convert';

GetAuthentication getAuthenticationFromJson(String str) => GetAuthentication.fromJson(json.decode(str));

String getAuthenticationToJson(GetAuthentication data) => json.encode(data.toJson());

class GetAuthentication {
    GetAuthentication({
        required this.data,
    });

    Data data;

    factory GetAuthentication.fromJson(Map<String, dynamic> json) => GetAuthentication(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.email,
        required this.password,
        required this.grantType,
    });

    String email;
    String password;
    String grantType;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        grantType: json["grantType"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "grantType": grantType,
    };
}
