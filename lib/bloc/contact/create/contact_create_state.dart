import 'package:resturant/models/contact/create_contact_model.dart';

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final CreateContactResponseModel response;

  ContactSuccess(this.response);
}

class ContactFailure extends ContactState {
  final String error;

  ContactFailure(this.error);
}
