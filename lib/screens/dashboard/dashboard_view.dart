import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/common_widgets/elliptical_widget.dart';
import 'package:university_app/common_widgets/elliptical2_widget.dart';
import 'package:university_app/common_widgets/utility_widgets.dart';
import 'package:university_app/routes.dart';
import 'package:university_app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:university_app/screens/dashboard/bloc/dashboard_event.dart';
import 'package:university_app/screens/dashboard/bloc/dashboard_state.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';
import 'package:university_app/utils/sharedpreferences_helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DashboardBloc _dashboardBloc;

  String? profileImagePath = '';
  String? userName = '';
  String? age = '';
  final Color color1 = const Color(0XFF015DEA);
  final Color color2 = const Color(0XFF01C4FA);

  @override
  void initState() {
    _dashboardBloc = DashboardBloc();
    _dashboardBloc.add(DashboardLoadingEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dashboardBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    double cheight = MediaQuery.of(context).size.height;
    double cwidth = MediaQuery.of(context).size.width;

    return BlocProvider<DashboardBloc>(
        create: (BuildContext context) => _dashboardBloc,
        child: BlocListener<DashboardBloc, DashboardState>(
            listener: (context, state) async {
          if (state is LogoutState) {
            await SharedpreferencesHelper.clearSP();
            if (!mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login, (Route<dynamic> route) => false);
          } else if (state is DashboardErrorState) {
            UtilityWidgets.showSnackBar(context, state.errorMessage);
          } else if (state is UniversityListScreenState) {
            _dashboardBloc.add(DashboardResetEvent());
            Navigator.of(context).pushNamed(Routes.universityList);
          }
        }, child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (BuildContext context, DashboardState state) {
          if (state is DashboardLoadedState) {
            profileImagePath = state.profileImagePath;
            userName = state.name;
            age = state.age;
          }
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    height: cheight,
                    width: cwidth,
                    color: const Color(0xff1D2951),
                  ),
                  EllipticalWidget(),
                  Elliptical2Widget(),
                  Positioned(
                      top: 20,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.logout_rounded),
                        color: Colors.white60,
                        onPressed: () {
                          _dashboardBloc.add(LogoutEvent());
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: cheight * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Stack(
                            children: <Widget>[
                              profileImagePath != null
                                  ? Container(
                                      width: cheight * 0.07,
                                      height: cheight * 0.07,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: FileImage(
                                                  File(profileImagePath!)))))
                                  : Image.asset(
                                      'user_avatar2.png',
                                      height: cheight * 0.06,
                                      width: cheight * .06,
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userName != null ? userName! : '',
                          style: TextStyle(
                              fontSize: cheight * 0.025,
                              color: Colors.white,
                              fontFamily: 'Poweto'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          age != null ? age! : '',
                          style: TextStyle(
                              fontSize: cheight * 0.025,
                              color: Colors.white,
                              fontFamily: 'Poweto'),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.5 * cheight,
                    left: 0,
                    right: 0,
                    child: Material(
                      color: Colors.white.withOpacity(0.0),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 20, right: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.topLeft,
                                begin: Alignment.topRight,
                                colors: [color1, color2]),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            )),
                        child: MaterialButton(
                          minWidth: cwidth * 0.5,
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            _dashboardBloc.add(UniversityListScreenEvent());
                          },
                          child: const Text("University List",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GilroySemiBold',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        })));
  }
}
