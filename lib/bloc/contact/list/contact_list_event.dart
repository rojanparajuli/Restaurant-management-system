
abstract class ContactListEvent {
  List<Object?> get props => [];
}

class ContactListLoad extends ContactListEvent {}

class ContactListSearch extends ContactListEvent {
  final String query;

  ContactListSearch(this.query);

  @override
  List<Object?> get props => [query];
}