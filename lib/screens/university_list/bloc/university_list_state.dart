import 'package:equatable/equatable.dart';
import 'package:university_app/screens/university_list/models/university_model.dart';

abstract class UniversityListState extends Equatable {}

class UniversityListLoadingState extends UniversityListState {
  UniversityListLoadingState();

  @override
  List<Object> get props => [];
}

class UniversityListLoadedState extends UniversityListState {
  UniversityListLoadedState({required this.univList});

  final List<UniversityModel> univList;

  @override
  List<Object> get props => [univList];
}

class UniversityListErrorState extends UniversityListState {
  UniversityListErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
