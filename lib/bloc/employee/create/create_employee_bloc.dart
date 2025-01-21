import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/employee/create/create_employee_event.dart';
import 'package:resturant/bloc/employee/create/create_employee_state.dart';
import 'package:resturant/service/employee/create_user_service.dart';
import 'dart:io';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final AddEmployeeService addEmployeeService;


  AddEmployeeBloc({
    required this.addEmployeeService,
  }) : super(AddEmployeeInitial()) {
    on<CreateEmployee>(_handleCreateEmployee);
    on<ResetState>(_onResetState);
  }
  
  void _onResetState(ResetState event, Emitter<AddEmployeeState> emit) {
    emit(AddEmployeeInitial());
  }

  Future<void> _handleCreateEmployee(
      CreateEmployee event, Emitter<AddEmployeeState> emit) async {
    emit(AddEmployeeLoading());
    try {
      

      final response = await addEmployeeService.createUsersList(
        event.addemployee,
        File(event.profileImage.path),
        File(event.citizenshipImage.path),
      );
      emit(AddEmployeeSucess(response));
    } catch (error) {
      emit(AddemployeeFailure(error.toString()));
    }
  }


  
}
