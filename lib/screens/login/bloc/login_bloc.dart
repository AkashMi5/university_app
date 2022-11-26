import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/screens/login/models/user_login.dart';
import 'package:university_app/screens/login/bloc/login_event.dart';
import 'package:university_app/screens/login/bloc/login_state.dart';
import 'package:university_app/services/api_manager.dart';
import 'package:university_app/utils/helper_functions.dart';
import 'package:university_app/utils/sharedpreferences_helper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiManager apiM = ApiManager();
  LoginBloc() : super(LoginInitialState(userName: '')) {
    on<LoginEvent>((event, emit) async {
      try {
        if (event is LoginLoadingEvent) {
          emit(LoginLoadingState());
        } else if (event is LoginUserNameTypingEvent) {
          emit(LoginUserNameUpdateState(userName: event.userName));
        } else if (event is UserNameSubmitEvent) {
          emit(LoginLoadingState());
          bool isConnected = false;
          await checkNetworkConnection().then((value) {
            isConnected = value;
          });
          if (isConnected) {
            String userName = event.userName;
            String deviceIdentifier =
                await SharedpreferencesHelper.getDeviceId() ?? '';
            try {
              var uResponse = await apiM.addUser(userName, deviceIdentifier);
              if (uResponse is UserLogin) {
                await saveUserData(uResponse);
                emit(
                    LoginDataSubmittedState(message: '', userLogin: uResponse));
              } else if (uResponse is String) {
                emit(LoginDataSubmittedState(
                    message: uResponse,
                    userLogin:
                        UserLogin(deviceId: '', username: '', userId: '')));
              } else {
                emit(LoginErrorState('Something went wrong!'));
              }
            } catch (e) {
              emit(LoginErrorState(e.toString()));
            }
          } else {
            emit(LoginErrorState('Internet not available'));
          }
        }
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }

  saveUserData(UserLogin userData) async {
    String _userId = userData.userId;
    await SharedpreferencesHelper.setUserId(_userId);
    await SharedpreferencesHelper.setUserName(userData.username);
    await SharedpreferencesHelper.setProfilePic('');
  }
}
