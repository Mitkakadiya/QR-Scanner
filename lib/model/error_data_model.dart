// To parse this JSON data, do
//
//     final errorDataModel = errorDataModelFromJson(jsonString);

import 'dart:convert';

ErrorDataModel errorDataModelFromJson(String str) => ErrorDataModel.fromJson(json.decode(str));

String errorDataModelToJson(ErrorDataModel data) => json.encode(data.toJson());

class ErrorDataModel {
  List<Error>? errors;

  ErrorDataModel({
    this.errors,
  });

  factory ErrorDataModel.fromJson(Map<String, dynamic> json) => ErrorDataModel(
    errors: json["errors"] == null ? [] : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}

class Error {
  String? type;
  String? value;
  String? msg;
  String? path;
  String? location;

  Error({
    this.type,
    this.value,
    this.msg,
    this.path,
    this.location,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    type: json["type"],
    value: json["value"],
    msg: json["msg"],
    path: json["path"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
    "msg": msg,
    "path": path,
    "location": location,
  };
}
