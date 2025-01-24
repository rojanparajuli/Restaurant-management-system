import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/contact/list/contact_list_bloc.dart';
import 'package:resturant/bloc/contact/list/contact_list_event.dart';
import 'package:resturant/bloc/contact/list/contact_list_state.dart';
import 'package:resturant/components/colors.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({super.key});

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactListBloc>().add(ContactListLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading:  false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 500,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Contacts',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  context.read<ContactListBloc>().add(ContactListSearch(query));
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ContactListBloc, ContactListState>(
              builder: (context, state) {
                if (state is ContactListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ContactListSuccess ||
                    state is ContactSearchSuccess) {
                  final contacts = state is ContactListSuccess
                      ? state.contactList
                      : (state as ContactSearchSuccess).filteredContacts;

                  if (contacts.isEmpty) {
                    return const Center(child: Text('No contacts found.'));
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
                      ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return Card(
                            color: Colors.transparent,
                            child: ListTile(
                              title: Text(contact.name ?? 'N/A',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(contact.phone ?? "N/A",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(contact.email ?? "N/A"),
                                  Text(contact.branch ?? "N/A"),
                                  Text(contact.role ?? "N/A"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                if (state is ContactListFailure) {
                  return Center(child: Text(state.error));
                }
                return const Center(child: Text('No contacts available.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
