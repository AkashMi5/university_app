import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {}

class SplashLoadingState extends SplashState {
  SplashLoadingState();

  @override
  List<Object> get props => [];
}

class SplashNavigateToOtherScreenState extends SplashState {
  SplashNavigateToOtherScreenState({required this.isUserLoggedin});

  final bool isUserLoggedin;

  @override
  List<Object> get props => [isUserLoggedin];
}

class SplashErrorState extends SplashState {
  SplashErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
