import 'dart:convert';

AttendanceListModel attendanceListModelFromJson(String str) =>
    AttendanceListModel.fromJson(json.decode(str));

String attendanceListModelToJson(AttendanceListModel data) =>
    json.encode(data.toJson());

class AttendanceListModel {
  int? count;
  List<Record>? records;

  AttendanceListModel({
    this.count,
    this.records,
  });

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) =>
      AttendanceListModel(
        count: json["count"],
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "records": List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class Record {
  int? id;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  LocationLatLong? locationLatLong;
  String? status;
  int? userId;

  Record({
    this.id,
    this.checkInTime,
    this.checkOutTime,
    this.locationLatLong,
    this.status,
    this.userId,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        checkInTime: DateTime.parse(json["check_in_time"]),
        checkOutTime: DateTime.parse(json["check_out_time"]),
        locationLatLong: LocationLatLong.fromJson(json["location_lat_long"]),
        status: json["status"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "check_in_time": checkInTime?.toIso8601String(),
        "check_out_time": checkOutTime?.toIso8601String(),
        "location_lat_long": locationLatLong?.toJson(),
        "status": status,
        "user_id": userId,
      };
}

class LocationLatLong {
  String? checkin;
  String? checkout;

  LocationLatLong({
    this.checkin,
    this.checkout,
  });

  factory LocationLatLong.fromJson(Map<String, dynamic> json) =>
      LocationLatLong(
        checkin: json["checkin"],
        checkout: json["checkout"],
      );

  Map<String, dynamic> toJson() => {
        "checkin": checkin,
        "checkout": checkout,
      };
}
