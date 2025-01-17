import 'dart:io';

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
  final File image;
  final int userId;
  UploadImageEvent(this.image, this.userId);
  @override
  List<Object?> get props => [
    image,
    userId,
  ];
}