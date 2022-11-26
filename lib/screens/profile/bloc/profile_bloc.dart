import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/screens/profile/bloc/profile_event.dart';
import 'package:university_app/screens/profile/bloc/profile_state.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';
import 'package:university_app/services/api_manager.dart';
import 'package:university_app/utils/sharedpreferences_helper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ApiManager apiM = ApiManager();
  ProfileBloc()
      : super(
            ProfileInitialState(profileData: ProfileModel(name: '', age: ''))) {
    on<ProfileEvent>((event, emit) async {
      try {
        if (event is ProfileLoadingEvent) {
          emit(ProfileLoadingState());
        } else if (event is NameTypingEvent) {
          emit(NameUpdateState(name: event.name));
        } else if (event is AgeTypingEvent) {
          emit(AgeUpdateState(age: event.age));
        } else if (event is ProfileDataSubmitEvent) {
          emit(ProfileLoadingState());
          ProfileModel profileModel = event.profileModel;
          await saveUserData(profileModel);
          emit(ProfileDataSubmittedState());
        } else if (event is PickProfilePhotoEvent) {
          await getImage();
          emit(PickProfilePhotoState());
        } else if (event is ProfileErrorEvent) {
          emit(ProfileErrorState(event.errorMessage));
        } else if (event is ProfileResetEvent) {
          emit(ProfileResetState());
        }
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });
  }

  saveUserData(ProfileModel profileData) async {
    await SharedpreferencesHelper.setProfileData(profileData);
  }

  getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    String imagePath = image!.path;
    await SharedpreferencesHelper.setProfilePic(imagePath);
  }
}
