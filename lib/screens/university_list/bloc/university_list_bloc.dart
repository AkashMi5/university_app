import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/screens/university_list/bloc/university_list_event.dart';
import 'package:university_app/screens/university_list/bloc/university_list_state.dart';
import 'package:university_app/screens/university_list/models/university_model.dart';
import 'package:university_app/services/api_manager.dart';
import 'package:university_app/services/db_provider.dart';
import 'package:university_app/utils/helper_functions.dart';

class UniversityListBloc
    extends Bloc<UniversityListEvent, UniversityListState> {
  ApiManager apiM = ApiManager();
  DBProvider database = DBProvider.db;
  UniversityListBloc() : super(UniversityListLoadingState()) {
    on<UniversityListEvent>((event, emit) async {
      try {
        if (event is UniversityListLoadingEvent) {
          emit(UniversityListLoadingState());
          bool isConnected = false;
          await checkNetworkConnection().then((value) {
            isConnected = value;
          });
          if (isConnected) {
            var response = await apiM.getUniversityData();

            if (response is List<UniversityModel>) {
              add(UniversityListLoadedEvent(univList: response));
            } else {
              emit(UniversityListErrorState(response.toString()));
            }
          } else {
            emit(UniversityListErrorState('You are offline!'));
            var response = await database.getAllUnivData();
            if (response is List<UniversityModel>) {
              add(UniversityListLoadedEvent(univList: response));
            } else {
              emit(UniversityListErrorState(response.toString()));
            }
          }
        } else if (event is UniversityListLoadedEvent) {
          emit(UniversityListLoadedState(univList: event.univList));
        } else if (event is UniversityListErrorEvent) {
          emit(UniversityListErrorState('Something went wrong!'));
        }
      } catch (e) {
        emit(UniversityListErrorState(e.toString()));
      }
    });
  }
}
