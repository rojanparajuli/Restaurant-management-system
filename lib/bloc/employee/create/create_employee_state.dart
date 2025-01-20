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