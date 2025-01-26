import 'dart:convert';

AttendanceListModel attendanceListModelFromJson(String str) =>
    AttendanceListModel.fromJson(json.decode(str));

String attendanceListModelToJson(AttendanceListModel data) =>
    json.encode(data.toJson());

class AttendanceListModel {
  final int? count;
  final List<Record>? records;

  AttendanceListModel({
    required this.count,
    required this.records,
  });

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) =>
      AttendanceListModel(
        count: json["count"] as int?,
        records: json["records"] != null
            ? List<Record>.from(
                (json["records"] as List).map((x) => Record.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "records": records?.map((x) => x.toJson()).toList(),
      };
}

class Record {
  final int? id;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final LocationLatLong? locationLatLong;
  final String? status;
  final int? userId;

  Record({
    required this.id,
    required this.checkInTime,
    required this.checkOutTime,
    required this.locationLatLong,
    required this.status,
    required this.userId,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"] as int?,
        checkInTime: json["check_in_time"] != null
            ? DateTime.parse(json["check_in_time"])
            : null,
        checkOutTime: json["check_out_time"] != null
            ? DateTime.parse(json["check_out_time"])
            : null,
        locationLatLong: json["location_lat_long"] != null
            ? LocationLatLong.fromJson(json["location_lat_long"])
            : null,
        status: json["status"] as String?,
        userId: json["user_id"] as int?,
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
  final String? checkin;
  final String? checkout;

  LocationLatLong({
    required this.checkin,
    required this.checkout,
  });

  factory LocationLatLong.fromJson(Map<String, dynamic> json) =>
      LocationLatLong(
        checkin: json["checkin"] as String?,
        checkout: json["checkout"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "checkin": checkin,
        "checkout": checkout,
      };
}
