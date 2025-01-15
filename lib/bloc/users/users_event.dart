
abstract class UserEvent  {
  List<Object?> get props => [];
}

class FetchUsersEvent extends UserEvent {}

class UserSearchEvent extends UserEvent {
  final String query;

  UserSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}