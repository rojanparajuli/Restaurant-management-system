class AddEmployeeRequestModel {
  String? username;
  String? email;
  String? password;
  String? role;
  String? fullname;
  String? gender;
  String? phonenumber;
  String? emergencycontact;
  String? address;
  String? permanentAddress;
  DateTime? joinDate;
  String? maritalStatus;
  String? religion;
  String? fatherName;
  DateTime? dateofbirth;
  String? pancard;
  String? citizenship;
  String? employeeid;
  String? employeeType;
  String? bankName;
  String? bankaccountnumber;
  String? bloodgroup;

  AddEmployeeRequestModel({
    this.username,
    this.email,
    this.password,
    this.role,
    this.fullname,
    this.gender,
    this.phonenumber,
    this.emergencycontact,
    this.address,
    this.permanentAddress,
    this.joinDate,
    this.maritalStatus,
    this.religion,
    this.fatherName,
    this.dateofbirth,
    this.pancard,
    this.citizenship,
    this.employeeid,
    this.employeeType,
    this.bankName,
    this.bankaccountnumber,
    this.bloodgroup,
  });

  factory AddEmployeeRequestModel.fromJson(Map<String, dynamic> json) =>
      AddEmployeeRequestModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        fullname: json["fullname"],
        gender: json["gender"],
        phonenumber: json["phonenumber"],
        emergencycontact: json["emergencycontact"],
        address: json["address"],
        permanentAddress: json["permanentAddress"],
        joinDate: DateTime.parse(json["join_date"]),
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        fatherName: json["fatherName"],
        dateofbirth: DateTime.parse(json["dateofbirth"]),
        pancard: json["pancard"],
        citizenship: json["citizenship"],
        employeeid: json["employeeid"],
        employeeType: json["employeeType"],
        bankName: json["bankName"],
        bankaccountnumber: json["bankaccountnumber"],
        bloodgroup: json["bloodgroup"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "role": role,
        "fullname": fullname,
        "gender": gender,
        "phonenumber": phonenumber,
        "emergencycontact": emergencycontact,
        "address": address,
        "permanentAddress": permanentAddress,
        "join_date":
            "${joinDate?.year.toString().padLeft(4, '0')}-${joinDate?.month.toString().padLeft(2, '0')}-${joinDate?.day.toString().padLeft(2, '0')}",
        "maritalStatus": maritalStatus,
        "religion": religion,
        "fatherName": fatherName,
        "dateofbirth":
            "${dateofbirth?.year.toString().padLeft(4, '0')}-${dateofbirth?.month.toString().padLeft(2, '0')}-${dateofbirth?.day.toString().padLeft(2, '0')}",
        "pancard": pancard,
        "citizenship": citizenship,
        "employeeid": employeeid,
        "employeeType": employeeType,
        "bankName": bankName,
        "bankaccountnumber": bankaccountnumber,
        "bloodgroup": bloodgroup,
      };
}

class AddEmployeeResponseModel {
  String? message;

  AddEmployeeResponseModel({
    this.message,
  });

  factory AddEmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      AddEmployeeResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
