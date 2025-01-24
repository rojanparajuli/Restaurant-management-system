import 'dart:convert';

List<ContactListModel> contactListModelFromJson(String str) =>
    List<ContactListModel>.from(
        json.decode(str).map((x) => ContactListModel.fromJson(x)));

String contactListModelToJson(List<ContactListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactListModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? branch;
  String? role;

  ContactListModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.branch,
    this.role,
  });

  factory ContactListModel.fromJson(Map<String, dynamic> json) =>
      ContactListModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        branch: json["branch"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "branch": branch,
        "role": role,
      };
}
