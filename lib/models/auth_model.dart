class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

class LoginResponseModel {
  String? token;
  String? message;
  String? role;

  LoginResponseModel({
    this.token,
    this.message,
    this.role,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
        message: json["message"],
        role: json["Role"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "message": message,
        "Role": role,
      };
}

class ForgetPasswordRequestModel {
  String? email;

  ForgetPasswordRequestModel({
    this.email,
  });

  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordRequestModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

class ForgetPasswordResponseModel {
  String? message;

  ForgetPasswordResponseModel({
    this.message,
  });

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}



class ChangetPasswordRequestModel {
    String? oldPassword;
    String? newPassword;

    ChangetPasswordRequestModel({
        this.oldPassword,
        this.newPassword,
    });

    factory ChangetPasswordRequestModel.fromJson(Map<String, dynamic> json) => ChangetPasswordRequestModel(
        oldPassword: json["old_password"],
        newPassword: json["new_password"],
    );

    Map<String, dynamic> toJson() => {
        "old_password": oldPassword,
        "new_password": newPassword,
    };
}

