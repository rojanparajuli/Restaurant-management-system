
import 'dart:io';

abstract class ImageChooseState {}

class ImageChooseInitial extends ImageChooseState {}

class ImageChooseLoading extends ImageChooseState {}

class ImageChooseSuccess extends ImageChooseState {
  final File imageUrl;
  ImageChooseSuccess(this.imageUrl);
}

class ImageChooseFailure extends ImageChooseState {
  final String errorMessage;
  ImageChooseFailure(this.errorMessage);
}
