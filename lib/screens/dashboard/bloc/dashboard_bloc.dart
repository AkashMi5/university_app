import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/screens/dashboard/bloc/dashboard_event.dart';
import 'package:university_app/screens/dashboard/bloc/dashboard_state.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';
import 'package:university_app/utils/sharedpreferences_helper.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoadingState()) {
    on<DashboardEvent>((event, emit) async {
      try {
        if (event is DashboardLoadingEvent) {
          List<String> userData = await getUserData();
          add(DashboardLoadedEvent(
              profileImagePath: userData[0],
              name: userData[1],
              age: userData[2]));
        } else if (event is DashboardLoadedEvent) {
          emit(DashboardLoadedState(
              profileImagePath: event.profileImagePath,
              name: event.name,
              age: event.age));
        } else if (event is UniversityListScreenEvent) {
          emit(UniversityListScreenState());
        } else if (event is LogoutEvent) {
          emit(LogoutState());
        } else if (event is DashboardErrorEvent) {
          emit(DashboardErrorState('Something went wrong!'));
        } else if (event is DashboardResetEvent) {
          emit(DashboardResetState());
        }
      } catch (e) {
        emit(DashboardErrorState(e.toString()));
      }
    });
  }

  Future<List<String>> getUserData() async {
    List<String> data = [];
    String? profileImagePath = await SharedpreferencesHelper.getProfilePic();
    String? userName = await SharedpreferencesHelper.getUserName();
    ProfileModel? profileModel = await SharedpreferencesHelper.getProfileData();
    String age = profileModel!.age;
    data.addAll([profileImagePath!, userName!, age]);

    return data;
  }
}
