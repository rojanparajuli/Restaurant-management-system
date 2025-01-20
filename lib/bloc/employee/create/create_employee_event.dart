import 'package:resturant/models/employee/add_employee_model.dart';

abstract class AddEmployeeEvent {}

class CreateEmployee extends AddEmployeeEvent {
  final AddEmployeeRequestModel addemployee;

  CreateEmployee(this.addemployee);
}