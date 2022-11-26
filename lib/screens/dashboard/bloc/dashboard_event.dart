import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {}

class DashboardLoadingEvent extends DashboardEvent {
  DashboardLoadingEvent();

  @override
  List<Object> get props => [];
}

class UniversityListScreenEvent extends DashboardEvent {
  UniversityListScreenEvent();

  @override
  List<Object> get props => [];
}

class DashboardLoadedEvent extends DashboardEvent {
  DashboardLoadedEvent(
      {required this.profileImagePath, required this.name, required this.age});

  final String profileImagePath;
  final String name;
  final String age;

  @override
  List<Object> get props => [profileImagePath, name, age];
}

class LogoutEvent extends DashboardEvent {
  LogoutEvent();

  @override
  List<Object> get props => [];
}

class DashboardResetEvent extends DashboardEvent {
  DashboardResetEvent();

  @override
  List<Object> get props => [];
}

class DashboardErrorEvent extends DashboardEvent {
  DashboardErrorEvent({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
