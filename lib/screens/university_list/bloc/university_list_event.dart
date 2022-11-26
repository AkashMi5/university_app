import 'package:equatable/equatable.dart';
import 'package:university_app/screens/university_list/models/university_model.dart';

abstract class UniversityListEvent extends Equatable {}

class UniversityListLoadingEvent extends UniversityListEvent {
  UniversityListLoadingEvent();

  @override
  List<Object> get props => [];
}

class UniversityListLoadedEvent extends UniversityListEvent {
  UniversityListLoadedEvent({required this.univList});

  final List<UniversityModel> univList;

  @override
  List<Object> get props => [univList];
}

class LogoutEvent extends UniversityListEvent {
  LogoutEvent();

  @override
  List<Object> get props => [];
}

class UniversityListErrorEvent extends UniversityListEvent {
  UniversityListErrorEvent({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
