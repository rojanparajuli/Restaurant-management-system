
abstract class EditUserState  {
  
  List<Object?> get props => [];
}

class EditUserInitial extends EditUserState {}

class EditUserLoading extends EditUserState {}

class EditUserSuccess extends EditUserState {
  final String message;

  EditUserSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EditUserError extends EditUserState {
  final String message;

  EditUserError(this.message);

  @override
  List<Object?> get props => [message];
}

class CitizenshipUpload extends EditUserState {
  final String message;

  CitizenshipUpload(this.message);

  @override
  List<Object?> get props => [message];
}

class CitizenshipUploadError extends EditUserState {
  final String message;

  CitizenshipUploadError(this.message);

  @override
  List<Object?> get props => [message];
}


class CitizenshipUploadLoading extends EditUserState {}
class CitizenshipUploadSuccess extends EditUserState {
  final String message;

  CitizenshipUploadSuccess(this.message);

  @override
  List<Object?> get props => [message];
}