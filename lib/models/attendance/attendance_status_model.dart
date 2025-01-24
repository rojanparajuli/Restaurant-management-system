import 'dart:convert';

AttendanceStatusGetModel attendanceStatusGetModelFromJson(String str) =>
    AttendanceStatusGetModel.fromJson(json.decode(str));

String attendanceStatusGetModelToJson(AttendanceStatusGetModel data) =>
    json.encode(data.toJson());

class AttendanceStatusGetModel {
  String? message;
  String? data;

  AttendanceStatusGetModel({
    this.message,
    this.data,
  });

  factory AttendanceStatusGetModel.fromJson(Map<String, dynamic> json) =>
      AttendanceStatusGetModel(
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}
