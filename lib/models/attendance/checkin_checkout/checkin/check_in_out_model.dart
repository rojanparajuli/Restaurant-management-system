class CheckInRequestModel {
  LocationLatLong? locationLatLong;

  CheckInRequestModel({
    this.locationLatLong,
  });

  factory CheckInRequestModel.fromJson(Map<String, dynamic> json) => CheckInRequestModel(
        locationLatLong: json["location_lat_long"] != null
            ? LocationLatLong.fromJson(json["location_lat_long"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "location_lat_long": locationLatLong?.toJson(),
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

class CheckInResponseModel {
  int? id;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  LocationLatLong? locationLatLong;
  String? status;
  int? userId;

  CheckInResponseModel({
    this.id,
    this.checkInTime,
    this.checkOutTime,
    this.locationLatLong,
    this.status,
    this.userId,
  });

  factory CheckInResponseModel.fromJson(Map<String, dynamic> json) => CheckInResponseModel(
        id: json["id"],
        checkInTime: json["check_in_time"] != null
            ? DateTime.parse(json["check_in_time"])
            : null,
        checkOutTime: json["check_out_time"] != null
            ? DateTime.parse(json["check_out_time"])
            : null,
        locationLatLong: json["location_lat_long"] != null
            ? LocationLatLong.fromJson(json["location_lat_long"])
            : null,
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