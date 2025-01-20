import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/employee/create/create_employee_event.dart';
import 'package:resturant/bloc/employee/create/create_employee_state.dart';
import 'package:resturant/service/employee/create_user_service.dart';

class AddEmployeeBloc extends Bloc <AddEmployeeEvent , AddEmployeeState> {

  final AddEmployeeService addEmployeeService;

  AddEmployeeBloc(this.addEmployeeService) : super(AddEmployeeInitial()){
    on<CreateEmployee>((event, emit) async {
      emit(AddEmployeeLoading());
      try {
        final response = await addEmployeeService.createUsersList(event.addemployee);
        emit(AddEmployeeSucess(response));
      } catch (error) {
        emit(AddemployeeFailure(error.toString()));
      }
    });
  }

}