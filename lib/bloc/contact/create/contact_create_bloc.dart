import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/contact/create/contact_create_event.dart';
import 'package:resturant/bloc/contact/create/contact_create_state.dart';
import 'package:resturant/service/contact/create_contact_service.dart';


class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService contactService;

  ContactBloc(this.contactService) : super(ContactInitial()) {
    on<CreateContact>((event, emit) async {
      emit(ContactLoading());
      try {
        final response = await contactService.createContact(event.contact);
        emit(ContactSuccess(response));
      } catch (error) {
        emit(ContactFailure(error.toString()));
      }
    });
  }
}
