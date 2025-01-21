import 'dart:convert';

UserImageModel userImageModelFromJson(String str) =>
    UserImageModel.fromJson(json.decode(str));

String userImageModelToJson(UserImageModel data) => json.encode(data.toJson());

class UserImageModel {
  String? profileImage;
  String? citizenshipImage;

  UserImageModel({
    this.profileImage,
    this.citizenshipImage,
  });

  factory UserImageModel.fromJson(Map<String, dynamic> json) => UserImageModel(
        profileImage: json["profile_image"],
        citizenshipImage: json["citizenship_image"],
      );

  Map<String, dynamic> toJson() => {
        "profile_image": profileImage,
        "citizenship_image": citizenshipImage,
      };
}
