import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/employee/create/create_employee_bloc.dart';
import 'package:resturant/bloc/employee/create/create_employee_event.dart';
import 'package:resturant/bloc/employee/create/create_employee_state.dart';
import 'package:resturant/bloc/employee/create/cubits/citizenship_img_cubit.dart';
import 'package:resturant/bloc/employee/create/cubits/profile_img_cubit.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/components/side_menu.dart';
import 'package:resturant/models/employee/add_employee_model.dart';
import 'dart:io';

import 'package:resturant/utilities/textfield_widget.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({
    super.key,
  });

  @override
  AddUserViewState createState() => AddUserViewState();
}

final AddEmployeeRequestModel requestModel = AddEmployeeRequestModel();

class AddUserViewState extends State<AddUserView> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final addressController = TextEditingController();
  final roleController = TextEditingController();
  final permanentAddressController = TextEditingController();
  final religionController = TextEditingController();
  final fatherNameController = TextEditingController();
  final pancardNumberController = TextEditingController();
  final citizenshipNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankAccountNumberController = TextEditingController();
  final branchController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final joinedDateController = TextEditingController();

  String selectedRole = "";
  String gender = "";
  String maritalStatus = "";
  String employeeType = "";
  String bloodGroup = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Employee',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
             Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    'assets/icons/Business.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  BlocBuilder<ProfileImageCubit, File?>(
                    builder: (context, state) {
                      if (state == null || state.path.isEmpty) {
                        return CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person, size: 50),
                        );
                      }
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(state.path)),
                      );
                    },
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.read<ProfileImageCubit>().pickProfileImage();
                    },
                    icon: Icon(Icons.image),
                    label: Text("Upload Image"),
                  ),
                  BlocBuilder<CitizenshipImageCubit, File?>(
                    builder: (context, state) {
                      if (state != null && state.path.isNotEmpty) {
                        return Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                              image: FileImage(File(state.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.shade300,
                        ),
                        child: Center(
                          child: Text("Citizenship Image"),
                        ),
                      );
                    },
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.read<CitizenshipImageCubit>().pickCitizenshipImage();
                    },
                    icon: Icon(Icons.image),
                    label: Text("Upload Citizenship Image"),
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomTextField(
                              labelText: 'Username',
                              controller: usernameController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Email', controller: emailController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Password', controller: passwordController)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomTextField(
                              labelText: 'Full Name',
                              controller: fullnameController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Phone Number',
                              controller: phoneNumberController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Emergency Contact',
                              controller: emergencyContactController)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomTextField(
                              labelText: 'Address', controller: addressController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Permanent Address',
                              controller: permanentAddressController),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 500,
                            child: TextField(
                              controller: dateOfBirthController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Date of Birth',
                                  hintText: 'Select Date of Birth',
                                  prefix: Icon(Icons.calendar_today)),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  dateOfBirthController.text =
                                      "${pickedDate.toLocal()}".split(' ')[0];
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomTextField(
                              labelText: 'Religion',
                              controller: religionController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Father Name',
                              controller: fatherNameController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Pan Number',
                              controller: pancardNumberController)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomTextField(
                              labelText: 'Citizenship number',
                              controller: citizenshipNumberController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Bank', controller: bankNameController),
                          SizedBox(width: 10),
                          CustomTextField(
                              labelText: 'Bank Account Number',
                              controller: bankAccountNumberController)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomTextField(
                              labelText: 'Restro branch',
                              controller: branchController),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 500,
                            child: DropdownButtonFormField<String>(
                              items: ['Admin', 'Supervisor', 'Staff', 'Chef']
                                  .map((role) => DropdownMenuItem(
                                        value: role,
                                        child: Text(role),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                selectedRole = value ?? "";
                              },
                              decoration: InputDecoration(
                                labelText: 'Role',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 500,
                            child: DropdownButtonFormField<String>(
                              items: ['Male', 'Female', 'Other']
                                  .map((g) => DropdownMenuItem(
                                        value: g,
                                        child: Text(g),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                gender = value ?? "";
                              },
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 500,
                            child: DropdownButtonFormField<String>(
                              items: ['Single', 'Married', 'Divorced', 'Widowed']
                                  .map((status) => DropdownMenuItem(
                                        value: status,
                                        child: Text(status),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                maritalStatus = value ?? "";
                              },
                              decoration: InputDecoration(
                                labelText: 'Marital Status',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 500,
                            child: DropdownButtonFormField<String>(
                              items: ['FullTime', 'PartTime']
                                  .map((type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                employeeType = value ?? "";
                              },
                              decoration: InputDecoration(
                                labelText: 'Employee Type',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 500,
                            child: DropdownButtonFormField<String>(
                              items:
                                  ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                                      .map((bg) => DropdownMenuItem(
                                            value: bg,
                                            child: Text(bg),
                                          ))
                                      .toList(),
                              onChanged: (value) {
                                bloodGroup = value ?? "";
                              },
                              decoration: InputDecoration(
                                labelText: 'Blood Group',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  BlocListener<AddEmployeeBloc, AddEmployeeState>(
                    listener: (context, state) {
                      if (state is AddEmployeeSucess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Employee Added Successfully"),
                          ),
                        );
                        context.read<ProfileImageCubit>().clearProfileImage();
                        context
                            .read<CitizenshipImageCubit>()
                            .clearCitizenshipImage();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SideMenu();
                        }));
                        context.read<AddEmployeeBloc>().add(ResetState());
                      } else if (state is AddemployeeFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    child: SizedBox(
                      height: 50,
                      width: 500,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          final addemployee = AddEmployeeRequestModel(
                            username: requestModel.username =
                                usernameController.text,
                            email: requestModel.email = emailController.text,
                            password: requestModel.password =
                                passwordController.text,
                            role: requestModel.role = selectedRole,
                            fullname: requestModel.fullname =
                                fullnameController.text,
                            address: requestModel.address = addressController.text,
                            phonenumber: requestModel.phonenumber =
                                phoneNumberController.text,
                            emergencycontact: requestModel.emergencycontact =
                                emergencyContactController.text,
                            permanentAddress: requestModel.permanentAddress =
                                permanentAddressController.text,
                            religion: requestModel.religion =
                                religionController.text,
                            fatherName: requestModel.fatherName =
                                fatherNameController.text,
                            pancard: requestModel.pancard =
                                pancardNumberController.text,
                            citizenship: requestModel.citizenship =
                                citizenshipNumberController.text,
                            bankName: requestModel.bankName =
                                bankNameController.text,
                            bankaccountnumber: requestModel.bankaccountnumber =
                                bankAccountNumberController.text,
                            bloodgroup: requestModel.bloodgroup = bloodGroup,
                            employeeType: requestModel.employeeType = employeeType,
                            gender: requestModel.gender = gender,
                            maritalStatus: requestModel.maritalStatus =
                                maritalStatus,
                            dateofbirth: requestModel.dateofbirth =
                                dateOfBirthController.text,
                            branch: requestModel.branch = branchController.text,
                          );
          
                          context.read<AddEmployeeBloc>().add(CreateEmployee(
                              addemployee,
                              context.read<ProfileImageCubit>().state!,
                              context.read<CitizenshipImageCubit>().state));
                        },
                        child: Text(
                          'Add Employee',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
