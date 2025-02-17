import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/contact/create/contact_create_bloc.dart';
import 'package:resturant/bloc/contact/create/contact_create_event.dart';
import 'package:resturant/bloc/contact/create/contact_create_state.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/models/contact/create_contact_model.dart';
import 'package:resturant/utilities/textfield_widget.dart';

class CreateContactScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _branchhController = TextEditingController();
  final _addressController = TextEditingController();

  CreateContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Contact',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Contact created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ContactFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ContactLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/icons/Business.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomTextField(
                                  labelText: "Name",
                                  controller: _nameController,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                CustomTextField(
                                    labelText: "Email",
                                    controller: _emailController),
                                SizedBox(
                                  width: 16,
                                ),
                                CustomTextField(
                                labelText: 'Address',
                                controller: _addressController),
                            const SizedBox(width: 16),
                              ],
                            ),
                            SizedBox(height: 40),

                            Row(
                              children: [
                               CustomTextField(
                                labelText: "Phone Number",
                                controller: _phoneController),
                            SizedBox(width: 16),
                            CustomTextField(
                                labelText: 'Branch',
                                controller: _branchhController),
                            SizedBox(width: 16),

                            ],),
                           SizedBox(height: 40,),
                            
                            SizedBox(
                              height: 50,
                              width: 500,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final contact = CreateContactModel(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        phone: _phoneController.text,
                                        branch: _branchhController.text,
                                        role: _addressController.text);
                                    context
                                        .read<ContactBloc>()
                                        .add(CreateContact(contact));
                                    _nameController.clear();
                                    _emailController.clear();
                                    _phoneController.clear();
                                    _branchhController.clear();
                                    _addressController.clear();
                                  }
                                },
                                child: Text(
                                  'Create Contact',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
