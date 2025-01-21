import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CitizenshipImageCubit extends Cubit<File> {
  CitizenshipImageCubit() : super(File(''));

  Future<void> pickCitizenshipImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(File(pickedFile.path));
    } else {
      emit(File(''));
    }
  }

  void clearCitizenshipImage() {
    emit(File(''));
  }
}
