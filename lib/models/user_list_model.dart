import 'dart:convert';

List<UsersList> usersListFromJson(String str) => List<UsersList>.from(json.decode(str).map((x) => UsersList.fromJson(x)));

String usersListToJson(List<UsersList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersList {
    int ?id;
    DateTime? lastLogin;
    bool ?isSuperuser;
    String? username;
    String? firstName;
    String? lastName;
    String? email;
    // bool? isStaff;
    bool? isActive;
    DateTime ?dateJoined;
    String? role;
    String? gender;
    String? phoneNumber;
    String? emergencyContact;
    String? address;
    String? permanentAddress;
    String? image;
    String? maritalStatus;
    String? religion;
    String? fatherName;
    DateTime? dateOfBirth;
    String? panCard;
    String? citizenship;
    String? citizenshipImage;
    String? employeeId;
    String? employeeType;
    String? bankName;
    String? bankAccountNumber;
    String? bloodGroup;
    String? branch;

    UsersList({
        this.id,
        this.lastLogin,
        this.isSuperuser,
        this.username,
        this.firstName,
        this.lastName,
        this.email,
        this.isActive,
        this.dateJoined,
        this.role,
        this.gender,
        this.phoneNumber,
        this.emergencyContact,
        this.address,
        this.permanentAddress,
        this.image,
        this.maritalStatus,
        this.religion,
        this.fatherName,
        this.dateOfBirth,
        this.panCard,
        this.citizenship,
        this.citizenshipImage,
        this.employeeId,
        this.employeeType,
        this.bankName,
        this.bankAccountNumber,
        this.bloodGroup,
        this.branch,
    });

   factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
  id: json["id"] as int?,
  lastLogin: json["last_login"] != null ? DateTime.tryParse(json["last_login"]) : null,
  isSuperuser: json["is_superuser"] as bool?,
  username: json["username"] as String?,
  firstName: json["first_name"] as String?,
  lastName: json["last_name"] as String?,
  email: json["email"] as String?,
  isActive: json["is_active"] as bool?,
  dateJoined: json["date_joined"] != null ? DateTime.tryParse(json["date_joined"]) : null,
  role: json["role"] as String?,
  gender: json["gender"] as String?,
  phoneNumber: json["phone_number"] as String?,
  emergencyContact: json["emergency_contact"] as String?,
  address: json["address"] as String?,
  permanentAddress: json["permanent_address"] as String?,
  image: json["image"] as String?,
  maritalStatus: json["marital_status"] as String?,
  religion: json["religion"] as String?,
  fatherName: json["father_name"] as String?,
  dateOfBirth: json["date_of_birth"] != null ? DateTime.tryParse(json["date_of_birth"]) : null,
  panCard: json["pan_card"] as String?,
  citizenship: json["citizenship"] as String?,
  citizenshipImage: json["citizenship_image"] as String?,
  employeeId: json["employee_id"] as String?,
  employeeType: json["employee_type"] as String?,
  bankName: json["bank_name"] as String?,
  bankAccountNumber: json["bank_account_number"] as String?,
  bloodGroup: json["blood_group"] as String?,
  branch: json["branch"] as String?,
);

    Map<String, dynamic> toJson() => {
     
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_active": isActive,
        "date_joined": dateJoined?.toIso8601String(),
        "role": role,
        "gender": gender,
        "phone_number": phoneNumber,
        "emergency_contact": emergencyContact,
        "address": address,
        "permanent_address": permanentAddress,
        "image": image,
        "marital_status": maritalStatus,
        "religion": religion,
        "father_name": fatherName,
        "date_of_birth": "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "pan_card": panCard,
        "citizenship": citizenship,
        "citizenship_image": citizenshipImage,
        "employee_id": employeeId,
        "employee_type": employeeType,
        "bank_name": bankName,
        "bank_account_number": bankAccountNumber,
        "blood_group": bloodGroup,
        "branch": branch,
    };
}
