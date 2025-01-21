import 'package:resturant/models/employee/add_employee_model.dart';

abstract class AddEmployeeState {}

class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeLoading extends AddEmployeeState {}

class AddEmployeeSucess extends AddEmployeeState {
  final AddEmployeeResponseModel response;

  AddEmployeeSucess(this.response);
}

class AddemployeeFailure extends AddEmployeeState {
  final String error;

  AddemployeeFailure(this.error);
}

class AddEmployeeImageSelected extends AddEmployeeState {
  final String? imagePath;
  final String? citizenshipImagePath;

  AddEmployeeImageSelected(this.imagePath, this.citizenshipImagePath);
}

class AddEmployeeImageSelectedLoading extends AddEmployeeState {}
class AddEmployeeImageSelectedError extends AddEmployeeState {
  final String error;

  AddEmployeeImageSelectedError(this.error);
}

class AddEmployeeImageSelectedSuccess extends AddEmployeeState {
  final String message;

  AddEmployeeImageSelectedSuccess(this.message);
}