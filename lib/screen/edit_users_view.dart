import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/api/colors.dart';
import 'package:resturant/bloc/users/edit/users_edit_bloc.dart';
import 'package:resturant/bloc/users/edit/users_edit_event.dart';
import 'package:resturant/bloc/users/edit/users_edit_state.dart';
import 'package:resturant/models/user_list_model.dart';

class EditUserScreen extends StatelessWidget {
  EditUserScreen({super.key, required this.user});
  final UsersList user;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emergencyContactController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController permanentAddressController =
      TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController(); 
  final TextEditingController dateOfBirthController = TextEditingController(); 
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController banknameController = TextEditingController();
  final TextEditingController bankAccountNumberController = TextEditingController();
  final TextEditingController branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstnameController.text = user.firstName.toString();
    lastnameController.text = user.lastName.toString();
    emailController.text = user.email.toString();
    phoneNumberController.text = user.phoneNumber.toString();
    emergencyContactController.text = user.emergencyContact.toString();
    addressController.text = user.address.toString();
    permanentAddressController.text = user.permanentAddress.toString();
    //add
    religionController.text = user.religion.toString();
    fatherNameController.text = user.fatherName.toString();
    dateOfBirthController.text = user.dateOfBirth.toString();
    panCardController.text = user.panCard.toString();
    citizenshipController.text = user.citizenship.toString();
    banknameController.text = user.bankName.toString();
    bankAccountNumberController.text = user.bankAccountNumber.toString();
    branchController.text = user.branch.toString();

    String selectedRole = user.role ?? "";
    String selectedEmployeeType = user.employeeType ?? "";
    String selectedGender = user.gender ?? "";
    String selectedBloodGroup = user.bloodGroup ?? "";
    String selectedMaritalStatus = user.maritalStatus ?? "";




    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: BlocListener<EditUserBloc, EditUserState>(
        listener: (context, state) {
          if (state is EditUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User updated successfully!')),
            );
            Navigator.pop(context, state.updatedUser);
          } else if (state is EditUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: emergencyContactController,
                  decoration: InputDecoration(labelText: 'Emergency Contact'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: permanentAddressController,
                  decoration: InputDecoration(labelText: 'Permanent Address'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items: ["Admin", "Supervisor", "Staff", "Chef"]
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedRole = value!;
                  },
                  decoration: InputDecoration(labelText: 'Role'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedEmployeeType,
                  items: ["FullTime", "PartTime"]
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedEmployeeType = value!;
                  },
                  decoration: InputDecoration(labelText: 'Employee Type'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ["Male", "Female", "Other"]
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedGender = value!;
                  },
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedBloodGroup,
                  items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                      .map((bloodGroup) => DropdownMenuItem(
                            value: bloodGroup,
                            child: Text(bloodGroup),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedBloodGroup = value!;
                  },
                  decoration: InputDecoration(labelText: 'Blood Group'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedMaritalStatus,
                  items: ["Married", "Unmarried", "Divorced", "Widowed"]
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedMaritalStatus = value!;
                  },
                  decoration: InputDecoration(labelText: 'Marital Status'),
                ),
                SizedBox(height: 32),
                BlocBuilder<EditUserBloc, EditUserState>(
                  builder: (context, state) {
                    if (state is EditUserLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final updatedUser = UsersList(
                            id: user.id,
                            firstName: firstnameController.text,
                            lastName: lastnameController.text,
                            email: emailController.text,
                            phoneNumber: phoneNumberController.text,
                            emergencyContact: emergencyContactController.text,
                            address: addressController.text,
                            permanentAddress: permanentAddressController.text,
                            role: selectedRole,
                            employeeType: selectedEmployeeType,
                            gender: selectedGender,
                            bloodGroup: selectedBloodGroup,
                            maritalStatus: selectedMaritalStatus,
                          );

                          context
                              .read<EditUserBloc>()
                              .add(EditUserSubmitEvent(updatedUser));
                        },
                        child: Text('Save'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
