


import 'package:image_picker/image_picker.dart';

abstract class ImageChooseState {}

class ImageChooseInitial extends ImageChooseState {}

class ImageChooseLoading extends ImageChooseState {}

class ImageChooseSuccess extends ImageChooseState {
  final XFile imageUrl;
  ImageChooseSuccess(this.imageUrl);
}

class ImageChooseFailure extends ImageChooseState {
  final String errorMessage;
  ImageChooseFailure(this.errorMessage);
}

class CitizenshipImageChooseSuccess extends ImageChooseState {
  final XFile imageUrl;
  CitizenshipImageChooseSuccess(this.imageUrl);
}



