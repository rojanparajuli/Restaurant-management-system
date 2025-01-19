import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resturant/bloc/employee/choose_image/image_choose_state.dart';

class ImageChooseCubit extends Cubit<ImageChooseState> {
  final ImagePicker _picker = ImagePicker();
  ImageChooseCubit() : super(ImageChooseInitial());

  Future<void> chooseProfilePicture() async {
      emit(ImageChooseLoading());

      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(ImageChooseSuccess(image));
      } else {
        emit(ImageChooseFailure("No image selected."));
      }

  }

  Future<void> chooseCitizenshipImage() async {
      emit(ImageChooseLoading());

      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(CitizenshipImageChooseSuccess(image));
      } else {
        emit(ImageChooseFailure("No image selected."));
      }

}
}
