
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/api/api.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/bloc/employee/choose_image/image_choose_state.dart';
import 'package:resturant/bloc/employee/edit/users_edit_bloc.dart';
import 'package:resturant/bloc/employee/edit/users_edit_event.dart';
import 'package:resturant/bloc/employee/edit/users_edit_state.dart';
import 'package:resturant/bloc/employee/choose_image/image_choose_cubit.dart';
import 'package:resturant/models/employee/user_list_model.dart';
import 'package:resturant/utilities/textfield_widget.dart';

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
  final TextEditingController bankAccountNumberController =
      TextEditingController();
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
            Navigator.pop(context);
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
                BlocListener<ImageChooseCubit, ImageChooseState>(

                  listener: (context, state) {
                    if (state is ImageChooseSuccess) {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: Text('Upload Image'),
                          content: Text('Are you sure you want to upload this image?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.read<EditUserBloc>().add(UploadImageEvent(state.imageUrl, user.id ??0 ));
                                Navigator.pop(context);
                                
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },);
                    } else if (state is ImageChooseFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${state.errorMessage}')),
                      );
                    }
                  },


                    child:  GestureDetector(
                      onTap: () {
                        context.read<ImageChooseCubit>().chooseProfilePicture();
                      },
                      child: Center(
                        child: user.image != null
                            ? Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        "${Api.mediaUrl}${user.image!}"),
                                  ),
                                  Positioned(
                                    top: 90,
                                    left: 90,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    child: Icon(Icons.person, size: 60),
                                  ),
                                  Positioned(
                                    top: 90,
                                    left: 90,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                        labelText: 'FirstName',
                        controller: firstnameController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'LastName', controller: lastnameController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'Email', controller: emailController),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                        labelText: 'PhoneNumber',
                        controller: phoneNumberController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'EmergencyContact',
                        controller: emergencyContactController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'Address', controller: addressController),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                        labelText: 'Permanent Address',
                        controller: permanentAddressController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'Religion', controller: religionController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'Father Name',
                        controller: fatherNameController),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                        labelText: 'Date of Birth',
                        controller: dateOfBirthController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'PAN Card', controller: panCardController),
                    SizedBox(width: 16),
                    CustomTextField(
                        labelText: 'Citizenship',
                        controller: citizenshipController),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                        labelText: 'Bank Name', controller: banknameController),
                    CustomTextField(
                        labelText: 'Bank Account Number',
                        controller: bankAccountNumberController),
                    CustomTextField(
                        labelText: 'Branch', controller: branchController),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 500,
                      child: DropdownButtonFormField<String>(
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
                        decoration: InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 500,
                      child: DropdownButtonFormField<String>(
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
                        decoration: InputDecoration(
                          labelText: 'Employee Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 500,
                      child: DropdownButtonFormField<String>(
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
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 500,
                      child: DropdownButtonFormField<String>(
                        value: selectedBloodGroup,
                        items:
                            ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
                                .map((bloodGroup) => DropdownMenuItem(
                                      value: bloodGroup,
                                      child: Text(bloodGroup),
                                    ))
                                .toList(),
                        onChanged: (value) {
                          selectedBloodGroup = value!;
                        },
                        decoration: InputDecoration(
                          labelText: 'Blood Group',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 500,
                      child: DropdownButtonFormField<String>(
                        value: selectedMaritalStatus,
                        items: ["Married", "Single", "Divorced", "Widowed"]
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                        onChanged: (value) {
                          selectedMaritalStatus = value!;
                        },
                        decoration: InputDecoration(
                          labelText: 'Marital Status',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 500,
                                height: 50,
                                child: Image.network(
                                  "${Api.mediaUrl}${user.citizenshipImage}",
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 90,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Upload Citizenship Image',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.upload_file,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32),
                BlocBuilder<EditUserBloc, EditUserState>(
                  builder: (context, state) {
                    if (state is EditUserLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: SizedBox(
                        width: 500,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
                          child: Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
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
