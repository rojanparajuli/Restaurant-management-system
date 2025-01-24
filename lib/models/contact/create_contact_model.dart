class CreateContactModel {
  String? name;
  String? email;
  String? phone;
  String ? branch;
  String ? role;

  CreateContactModel({
    this.name,
    this.email,
    this.phone,
    this.branch,
    this.role
  });

  factory CreateContactModel.fromJson(Map<String, dynamic> json) =>
      CreateContactModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        branch: json["branch"],
        role: json["role"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "branch": branch,
        "role": role
      };
}

class CreateContactResponseModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? message;
    String ? role;
  String ? branch;


  CreateContactResponseModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.message,
    this.role,
    this.branch
  });

  factory CreateContactResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateContactResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        message: json["message"],
        role: json["role"],
        branch: json["branch"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "message": message,
        "role": role,
        "branch": branch
      };
}
