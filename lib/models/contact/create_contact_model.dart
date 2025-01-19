class CreateContactModel {
  String? name;
  String? email;
  String? phone;

  CreateContactModel({
    this.name,
    this.email,
    this.phone,
  });

  factory CreateContactModel.fromJson(Map<String, dynamic> json) =>
      CreateContactModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
      };
}

class CreateContactResponseModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? message;

  CreateContactResponseModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.message,
  });

  factory CreateContactResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateContactResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "message": message,
      };
}
