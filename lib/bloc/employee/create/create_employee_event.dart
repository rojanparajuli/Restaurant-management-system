import 'dart:io';

import 'package:resturant/models/employee/add_employee_model.dart';

abstract class AddEmployeeEvent {}

class CreateEmployee extends AddEmployeeEvent {
  final AddEmployeeRequestModel addemployee;
  final File profileImage;
  final File citizenshipImage;

  CreateEmployee(this.addemployee, this.profileImage, this.citizenshipImage);
}

class PickImage extends AddEmployeeEvent {
  PickImage();
}

class PickCitizenshipImage extends AddEmployeeEvent {}

class UploadProfilePicture extends AddEmployeeEvent {}

class UploadCitizenshipImage extends AddEmployeeEvent {}

class ResetState extends AddEmployeeEvent {}