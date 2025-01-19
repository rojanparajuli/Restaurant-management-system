import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/contact/contact_create_bloc.dart';
import 'package:resturant/bloc/contact/contact_create_event.dart';
import 'package:resturant/bloc/contact/contact_create_state.dart';
import 'package:resturant/models/contact/create_contact_model.dart';

class CreateContactScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  CreateContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Contact')),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Contact created successfully!')),
            );
          } else if (state is ContactFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is ContactLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter a valid name' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter a valid email' : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter a valid phone' : null,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final contact = CreateContactModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                        );
                        context.read<ContactBloc>().add(CreateContact(contact));
                      }
                    },
                    child: Text('Create Contact'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
