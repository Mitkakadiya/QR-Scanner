// To parse this JSON data, do
//
//     final ticketDataModel = ticketDataModelFromJson(jsonString);

import 'dart:convert';

List<TicketDataModel> ticketDataModelFromJson(String str) => List<TicketDataModel>.from(json.decode(str).map((x) => TicketDataModel.fromJson(x)));

String ticketDataModelToJson(List<TicketDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketDataModel {
  String? id;
  String? type;
  String? status;
  DateTime? date;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TicketDataModel({
    this.id,
    this.type,
    this.status,
    this.date,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TicketDataModel.fromJson(Map<String, dynamic> json) => TicketDataModel(
    id: json["id"],
    type: json["type"],
    status: json["status"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "status": status,
    "date": date?.toIso8601String(),
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
