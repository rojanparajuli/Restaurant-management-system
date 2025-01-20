import 'package:resturant/models/contact/contact_list_model.dart';

abstract class ContactListState  {
  List<Object?> get props => [];
}

class ContactListInitial extends ContactListState {}

class ContactListLoading extends ContactListState {}

class ContactListSuccess extends ContactListState {
  final List<ContactListModel> contactList;

  ContactListSuccess(this.contactList);

  @override
  List<Object?> get props => [contactList];
}

class ContactListFailure extends ContactListState {
  final String error;

  ContactListFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ContactSearchSuccess extends ContactListState {
  final List<ContactListModel> filteredContacts;

  ContactSearchSuccess(this.filteredContacts);

  @override
  List<Object?> get props => [filteredContacts];
}
