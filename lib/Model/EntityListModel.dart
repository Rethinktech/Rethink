// To parse this JSON data, do
//
//     final entityListModel = entityListModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<EntityListModel> entityListModelFromJson(String str) => List<EntityListModel>.from(json.decode(str).map((x) => EntityListModel.fromJson(x)));

String entityListModelToJson(List<EntityListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EntityListModel {
    EntityListModel({
        required this.account,
        required this.status,
        required this.rethinkpharmaceuticaldemoId,
        required this.createdBy,
        required this.createdDate,
        required this.updatedBy,
        required this.updatedDate,
    });

    Account account;
    String status;
    String rethinkpharmaceuticaldemoId;
    AtedBy createdBy;
    DateTime createdDate;
    AtedBy updatedBy;
    DateTime updatedDate;

    factory EntityListModel.fromJson(Map<String, dynamic> json) => EntityListModel(
        account: Account.fromJson(json["account"]),
        status: json["status"],
        rethinkpharmaceuticaldemoId: json["_rethinkpharmaceuticaldemoId"],
        createdBy: AtedBy.fromJson(json["createdBy"]),
        createdDate: DateTime.parse(json["createdDate"]),
        updatedBy: AtedBy.fromJson(json["updatedBy"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "account": account.toJson(),
        "status": status,
        "_rethinkpharmaceuticaldemoId": rethinkpharmaceuticaldemoId,
        "createdBy": createdBy.toJson(),
        "createdDate": createdDate.toIso8601String(),
        "updatedBy": updatedBy.toJson(),
        "updatedDate": updatedDate.toIso8601String(),
    };
}

class Account {
    Account({
        required this.accountId,
    });

    String accountId;

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountId: json["_accountId"],
    );

    Map<String, dynamic> toJson() => {
        "_accountId": accountId,
    };
}

class AtedBy {
    AtedBy({
        required this.user,
        required this.name,
    });

    String user;
    String name;

    factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
        user: json["user"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
    };
}
