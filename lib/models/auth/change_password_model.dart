class ChangePasswordRequestModel {
  String? oldPassword;
  String? newPassword;

  ChangePasswordRequestModel({
    this.oldPassword,
    this.newPassword,
  });

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequestModel(
        oldPassword: json["old_password"],
        newPassword: json["new_password"],
      );

  Map<String, dynamic> toJson() => {
        "old_password": oldPassword,
        "new_password": newPassword,
      };
}

class ChangePasswordResponseModel {
  final String? message;
  final String? error;

  ChangePasswordResponseModel({
    this.message,
    this.error,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      message: json["message"] as String?,
      error: json["error"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) "message": message,
      if (error != null) "error": error,
    };
  }
}
