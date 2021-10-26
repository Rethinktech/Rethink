// To parse this JSON data, do
//
//     final entityList = entityListFromJson(jsonString);

import 'dart:convert';

EntityList entityListFromJson(String str) => EntityList.fromJson(json.decode(str));

String entityListToJson(EntityList data) => json.encode(data.toJson());

class EntityList {
    EntityList({
        required this.requestStatus,
        required this.errors,
        required this.warnings,
        required this.requestedAt,
        required this.data,
        required this.page,
        required this.itemsPerPage,
        required this.itemsInResponse,
        required this.totalItems,
        required this.processedAt,
    });

    bool requestStatus;
    List<dynamic> errors;
    List<dynamic> warnings;
    DateTime requestedAt;
    Data data;
    String page;
    String itemsPerPage;
    int itemsInResponse;
    int totalItems;
    DateTime processedAt;

    factory EntityList.fromJson(Map<String, dynamic> json) => EntityList(
        requestStatus: json["requestStatus"],
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
        requestedAt: DateTime.parse(json["requestedAt"]),
        data: Data.fromJson(json["data"]),
        page: json["page"],
        itemsPerPage: json["items_per_page"],
        itemsInResponse: json["items_in_response"],
        totalItems: json["total_items"],
        processedAt: DateTime.parse(json["processedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "requestStatus": requestStatus,
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
        "requestedAt": requestedAt.toIso8601String(),
        "data": data.toJson(),
        "page": page,
        "items_per_page": itemsPerPage,
        "items_in_response": itemsInResponse,
        "total_items": totalItems,
        "processedAt": processedAt.toIso8601String(),
    };
}

class Data {
    Data({
        required this.rethinkpharmaceuticaldemo,
    });

    List<Rethinkpharmaceuticaldemo> rethinkpharmaceuticaldemo;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        rethinkpharmaceuticaldemo: List<Rethinkpharmaceuticaldemo>.from(json["rethinkpharmaceuticaldemo"].map((x) => Rethinkpharmaceuticaldemo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "rethinkpharmaceuticaldemo": List<dynamic>.from(rethinkpharmaceuticaldemo.map((x) => x.toJson())),
    };
}

class Rethinkpharmaceuticaldemo {
    Rethinkpharmaceuticaldemo({
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

    factory Rethinkpharmaceuticaldemo.fromJson(Map<String, dynamic> json) => Rethinkpharmaceuticaldemo(
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
