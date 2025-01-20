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

  ContactListModel({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory ContactListModel.fromJson(Map<String, dynamic> json) =>
      ContactListModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
      };
}
