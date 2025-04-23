// To parse this JSON data, do
//
//     final approveTicketDataModel = approveTicketDataModelFromJson(jsonString);

import 'dart:convert';

ApproveTicketDataModel approveTicketDataModelFromJson(String str) => ApproveTicketDataModel.fromJson(json.decode(str));

String approveTicketDataModelToJson(ApproveTicketDataModel data) => json.encode(data.toJson());

class ApproveTicketDataModel {
  bool? acknowledged;
  int? modifiedCount;
  dynamic upsertedId;
  int? upsertedCount;
  int? matchedCount;

  ApproveTicketDataModel({
    this.acknowledged,
    this.modifiedCount,
    this.upsertedId,
    this.upsertedCount,
    this.matchedCount,
  });

  factory ApproveTicketDataModel.fromJson(Map<String, dynamic> json) => ApproveTicketDataModel(
        acknowledged: json["acknowledged"],
        modifiedCount: json["modifiedCount"],
        upsertedId: json["upsertedId"],
        upsertedCount: json["upsertedCount"],
        matchedCount: json["matchedCount"],
      );

  Map<String, dynamic> toJson() => {
        "acknowledged": acknowledged,
        "modifiedCount": modifiedCount,
        "upsertedId": upsertedId,
        "upsertedCount": upsertedCount,
        "matchedCount": matchedCount,
      };
}
