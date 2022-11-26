import 'package:equatable/equatable.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  ProfileInitialState({required this.profileData});

  final ProfileModel profileData;

  @override
  List<Object> get props => [profileData];
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState();

  @override
  List<Object> get props => [];
}

class ProfileDataSubmittedState extends ProfileState {
  ProfileDataSubmittedState();

  @override
  List<Object> get props => [];
}

class NameUpdateState extends ProfileState {
  NameUpdateState({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class AgeUpdateState extends ProfileState {
  AgeUpdateState({required this.age});

  final String age;

  @override
  List<Object> get props => [age];
}

class PickProfilePhotoState extends ProfileState {
  PickProfilePhotoState();

  @override
  List<Object> get props => [];
}

class ProfileResetState extends ProfileState {
  ProfileResetState();

  @override
  List<Object> get props => [];
}

class ProfileErrorState extends ProfileState {
  ProfileErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
