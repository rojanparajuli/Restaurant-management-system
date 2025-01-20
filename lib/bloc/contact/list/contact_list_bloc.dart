import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/contact/list/contact_list_event.dart';
import 'package:resturant/bloc/contact/list/contact_list_state.dart';
import 'package:resturant/models/contact/contact_list_model.dart';

import 'package:resturant/service/contact/contact_list_service.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactListService contactListService;

  List<ContactListModel> _allContacts = [];

  ContactListBloc(this.contactListService) : super(ContactListInitial()) {
    on<ContactListLoad>((event, emit) async {
      emit(ContactListLoading());
      try {
        final response = await contactListService.getContactList();
        _allContacts = response;
        emit(ContactListSuccess(response));
      } catch (error) {
        emit(ContactListFailure(error.toString()));
      }
    });

    on<ContactListSearch>((event, emit) {
      final filteredContacts = _allContacts
          .where((contact) =>
              contact.name?.toLowerCase().contains(event.query.toLowerCase()) ??
              false)
          .toList();
      emit(ContactSearchSuccess(filteredContacts));
    });
  }
}
