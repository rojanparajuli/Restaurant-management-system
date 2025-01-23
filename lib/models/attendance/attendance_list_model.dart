import 'dart:convert';

List<AttendanceListModel> attendanceListModelFromJson(String str) => List<AttendanceListModel>.from(json.decode(str).map((x) => AttendanceListModel.fromJson(x)));

String attendanceListModelToJson(List<AttendanceListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceListModel {
    int ?id;
    DateTime? checkInTime;
    DateTime? checkOutTime;
    LocationLatLong ?locationLatLong;
    int ?userId;

    AttendanceListModel({
        this.id,
        this.checkInTime,
        this.checkOutTime,
        this.locationLatLong,
        this.userId,
    });

    factory AttendanceListModel.fromJson(Map<String, dynamic> json) => AttendanceListModel(
        id: json["id"],
        checkInTime: DateTime.parse(json["check_in_time"]),
        checkOutTime: DateTime.parse(json["check_out_time"]),
        locationLatLong: LocationLatLong.fromJson(json["location_lat_long"]),
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "check_in_time": checkInTime?.toIso8601String(),
        "check_out_time": checkOutTime?.toIso8601String(),
        "location_lat_long": locationLatLong?.toJson(),
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

    factory LocationLatLong.fromJson(Map<String, dynamic> json) => LocationLatLong(
        checkin: json["checkin"],
        checkout: json["checkout"],
    );

    Map<String, dynamic> toJson() => {
        "checkin": checkin,
        "checkout": checkout,
    };
}