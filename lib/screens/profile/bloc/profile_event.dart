import 'package:equatable/equatable.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileLoadingEvent extends ProfileEvent {
  ProfileLoadingEvent();

  @override
  List<Object> get props => [];
}

class NameTypingEvent extends ProfileEvent {
  NameTypingEvent({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class AgeTypingEvent extends ProfileEvent {
  AgeTypingEvent({required this.age});

  final String age;

  @override
  List<Object> get props => [age];
}

class ProfileDataSubmitEvent extends ProfileEvent {
  ProfileDataSubmitEvent({required this.profileModel});

  final ProfileModel profileModel;

  @override
  List<Object> get props => [profileModel];
}

class PickProfilePhotoEvent extends ProfileEvent {
  PickProfilePhotoEvent();

  @override
  List<Object> get props => [];
}

class ProfileResetEvent extends ProfileEvent {
  ProfileResetEvent();

  @override
  List<Object> get props => [];
}

class ProfileErrorEvent extends ProfileEvent {
  ProfileErrorEvent({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
