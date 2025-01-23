abstract class DeleteUserState {
  const DeleteUserState();

  List<Object?> get props => [];
}

class DeleteUserStateInitial extends DeleteUserState {
  const DeleteUserStateInitial();
}

class DeleteUserStateLoading extends DeleteUserState {
  const DeleteUserStateLoading();
}

class DeleteUserStateSuccess extends DeleteUserState {
  final String message;

  const DeleteUserStateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteUserStateError extends DeleteUserState {
  final String message;

  const DeleteUserStateError(this.message);

  @override
  List<Object?> get props => [message];
}
