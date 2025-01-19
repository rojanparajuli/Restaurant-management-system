import 'package:resturant/models/contact/create_contact_model.dart';

abstract class ContactEvent {}

class CreateContact extends ContactEvent {
  final CreateContactModel contact;

  CreateContact(this.contact);
}
