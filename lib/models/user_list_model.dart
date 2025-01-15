import 'dart:convert';

List<UsersList> usersListFromJson(String str) => List<UsersList>.from(json.decode(str).map((x) => UsersList.fromJson(x)));

String usersListToJson(List<UsersList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersList {
    int ?id;
    String? password;
    DateTime? lastLogin;
    bool ?isSuperuser;
    String? username;
    String? firstName;
    String? lastName;
    String? email;
    bool? isStaff;
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
    List<dynamic> ?groups;
    List<dynamic> ?userPermissions;

    UsersList({
        this.id,
        this.password,
        this.lastLogin,
        this.isSuperuser,
        this.username,
        this.firstName,
        this.lastName,
        this.email,
        this.isStaff,
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
        this.groups,
        this.userPermissions,
    });

    factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        role: json["role"],
        gender: json["gender"],
        phoneNumber: json["phone_number"],
        emergencyContact: json["emergency_contact"],
        address: json["address"],
        permanentAddress: json["permanent_address"],
        image: json["image"],
        maritalStatus: json["marital_status"],
        religion: json["religion"],
        fatherName: json["father_name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        panCard: json["pan_card"],
        citizenship: json["citizenship"],
        citizenshipImage: json["citizenship_image"],
        employeeId: json["employee_id"],
        employeeType: json["employee_type"],
        bankName: json["bank_name"],
        bankAccountNumber: json["bank_account_number"],
        bloodGroup: json["blood_group"],
        branch: json["branch"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin?.toIso8601String(),
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
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
        "groups": List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions!.map((x) => x)),
    };
}
