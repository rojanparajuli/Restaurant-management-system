
import 'package:image_picker/image_picker.dart';
import 'package:resturant/models/user_list_model.dart';

abstract class EditUserEvent  {
  List<Object?> get props => [];
}

class EditUserSubmitEvent extends EditUserEvent {
  final UsersList updatedUser;

  EditUserSubmitEvent(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class UploadImageEvent extends EditUserEvent {
  final XFile image;
  final int userId;
  UploadImageEvent(this.image, this.userId);
  @override
  List<Object?> get props => [
    image,
    userId,
  ];
}

class UploadCitizenshipEvent extends EditUserEvent {
  final XFile image;
  final int userId;
  UploadCitizenshipEvent(this.image, this.userId);
  @override
  List<Object?> get props => [
    image,
    userId,
  ];
}