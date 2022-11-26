import 'package:flutter/material.dart';
import 'package:university_app/routes.dart';
import 'package:university_app/screens/splash/bloc/splash_bloc.dart';
import 'package:university_app/screens/splash/bloc/splash_event.dart';
import 'package:university_app/screens/splash/bloc/splash_state.dart';
import 'package:university_app/utils/helper_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/common_widgets/functional_widgets.dart';
import 'package:university_app/common_widgets/utility_widgets.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  void initialization() {}

  @override
  Widget build(BuildContext context) {
    setDeviceOrientationPortraitOnly();
    return Scaffold(
      body: Material(
        child: BlocProvider<SplashBloc>(
            create: (BuildContext context) =>
                SplashBloc()..add(SplashLoadingEvent()),
            child: BlocListener<SplashBloc, SplashState>(
              listener: (context, state) {
                if (state is SplashNavigateToOtherScreenState) {
                  if (state.isUserLoggedin) {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.dashboard);
                  } else {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  }
                } else if (state is SplashErrorState) {
                  UtilityWidgets.showSnackBar(context, state.errorMessage);
                }
              },
              child: BlocBuilder<SplashBloc, SplashState>(
                builder: (BuildContext context, SplashState state) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0XFF015DEA), Color(0XFF01C4FA)],
                          tileMode: TileMode.repeated),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'trivia_logo.png',
                                color: Colors.white70,
                                height: 190,
                                width: 190,
                              ),
                              const SizedBox(height: 40),
                              if (state is SplashLoadingState)
                                const CircularProgressIndicator(
                                    color: Colors.white70)
                              else if (state is SplashErrorState)
                                TryAgainButton(
                                    onButtonPress: () =>
                                        BlocProvider.of<SplashBloc>(context)
                                          ..add(SplashLoadingEvent()))
                            ],
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Text(
                              "",
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NunitoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
