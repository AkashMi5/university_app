import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {}

class DashboardLoadingState extends DashboardState {
  DashboardLoadingState();

  @override
  List<Object> get props => [];
}

class UniversityListScreenState extends DashboardState {
  UniversityListScreenState();

  @override
  List<Object> get props => [];
}

class DashboardLoadedState extends DashboardState {
  DashboardLoadedState(
      {required this.profileImagePath, required this.name, required this.age});

  final String profileImagePath;
  final String name;
  final String age;

  @override
  List<Object> get props => [profileImagePath, name, age];
}

class LogoutState extends DashboardState {
  LogoutState();

  @override
  List<Object> get props => [];
}

class DashboardResetState extends DashboardState {
  DashboardResetState();

  @override
  List<Object> get props => [];
}

class DashboardErrorState extends DashboardState {
  DashboardErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
