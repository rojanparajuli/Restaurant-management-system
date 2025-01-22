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

class AddUserView extends StatefulWidget {
  const AddUserView({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddUserViewState createState() => _AddUserViewState();
}

final AddEmployeeRequestModel requestModel = AddEmployeeRequestModel();

class _AddUserViewState extends State<AddUserView> {
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
          'Add User',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter Username',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter Email',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
              ),
              TextField(
                controller: fullnameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter Full Name',
                ),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter Phone Number',
                ),
              ),
              TextField(
                controller: emergencyContactController,
                decoration: InputDecoration(
                  labelText: 'Emergency Contact',
                  hintText: 'Enter Emergency Contact',
                ),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter Address',
                ),
              ),
              DropdownButtonFormField<String>(
                // value: selectedRole,
                items: ['Admin', 'Supervisor', 'Staff', 'Chef']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  // setState(() {
                  selectedRole = value ?? "";
                  // });
                },
                decoration: InputDecoration(
                  labelText: 'Role',
                ),
              ),
              TextField(
                controller: permanentAddressController,
                decoration: InputDecoration(
                  labelText: 'Permanent Address',
                  hintText: 'Enter Permanent Address',
                ),
              ),
              DropdownButtonFormField<String>(
                // value: gender,
                items: ['Male', 'Female', 'Other']
                    .map((g) => DropdownMenuItem(
                          value: g,
                          child: Text(g),
                        ))
                    .toList(),
                onChanged: (value) {
                  // setState(() {
                  gender = value ?? "";
                  // });
                },
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
              ),
              DropdownButtonFormField<String>(
                // value: maritalStatus,
                items: ['Single', 'Married', 'Divorced', 'Widowed']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  // setState(() {
                  maritalStatus = value ?? "";
                  // });
                },
                decoration: InputDecoration(
                  labelText: 'Marital Status',
                ),
              ),
              DropdownButtonFormField<String>(
                // value: employeeType,
                items: ['FullTime', 'PartTime']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  // setState(() {
                  employeeType = value ?? "";
                  // });
                },
                decoration: InputDecoration(
                  labelText: 'Employee Type',
                ),
              ),
              DropdownButtonFormField<String>(
                // value: bloodGroup,
                items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                    .map((bg) => DropdownMenuItem(
                          value: bg,
                          child: Text(bg),
                        ))
                    .toList(),
                onChanged: (value) {
                  // setState(() {
                  bloodGroup = value ?? "";
                  // });
                },
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                ),
              ),
              TextField(
                controller: dateOfBirthController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: 'Select Date of Birth',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    // setState(() {
                    dateOfBirthController.text =
                        "${pickedDate.toLocal()}".split(' ')[0];
                    // });
                  }
                },
              ),
              TextField(
                controller: religionController,
                decoration: InputDecoration(
                  labelText: 'Religion',
                  hintText: 'Enter Religion',
                ),
              ),
              TextField(
                controller: fatherNameController,
                decoration: InputDecoration(
                  labelText: 'Father Name',
                  hintText: 'Enter Father Name',
                ),
              ),
              TextField(
                controller: pancardNumberController,
                decoration: InputDecoration(
                  labelText: 'Pancard Number',
                  hintText: 'Enter Pancard Number',
                ),
              ),
              TextField(
                controller: citizenshipNumberController,
                decoration: InputDecoration(
                  labelText: 'Citizenship Number',
                  hintText: 'Enter Citizenship Number',
                ),
              ),
              TextField(
                controller: bankNameController,
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  hintText: 'Enter Bank Name',
                ),
              ),
              TextField(
                controller: bankAccountNumberController,
                decoration: InputDecoration(
                  labelText: 'Bank Account Number',
                  hintText: 'Enter Bank Account Number',
                ),
              ),
              TextField(
                controller: branchController,
                decoration: InputDecoration(
                  labelText: 'Branch',
                  hintText: 'Enter Branch',
                ),
              ),
              SizedBox(height: 20),
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
                child: ElevatedButton(
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

                      print("Submitted data: ${requestModel.toJson()}");
                      context.read<AddEmployeeBloc>().add(CreateEmployee(
                          addemployee,
                          context.read<ProfileImageCubit>().state!,
                          context.read<CitizenshipImageCubit>().state));
                    },
                    child: Text('Add Employee')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
