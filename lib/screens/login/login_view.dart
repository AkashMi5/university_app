import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/common_widgets/utility_widgets.dart';
import 'package:university_app/routes.dart';
import 'package:university_app/screens/login/bloc/login_bloc.dart';
import 'package:university_app/screens/login/bloc/login_event.dart';
import 'package:university_app/screens/login/bloc/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final bool visibilityOb = true;
  final Color color1 = const Color(0XFF015DEA);
  final Color color2 = const Color(0XFF01C4FA);
  final String _dialogTitle = 'Alert';
  final String _dialogDesc = 'Username already exists, try with other one!';
  final String _dialogButtonText = 'Okay';
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();
    _usernameController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _loginBloc.close();
  }

  _showDialog() {
    // return object of type Dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: _dialogTitle,
        description: _dialogDesc,
        buttonText: _dialogButtonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cheight = MediaQuery.of(context).size.height;
    double cwidth = MediaQuery.of(context).size.width;

    return BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginErrorState) {
            UtilityWidgets.showSnackBar(context, state.errorMessage);
          } else if (state is LoginDataSubmittedState) {
            if (state.message == '') {
              Navigator.of(context).pushReplacementNamed(Routes.profile);
            } else if (state.message != '') {
              if (state.message == 'Username taken by someone else') {
                _showDialog();
              } else {
                UtilityWidgets.showSnackBar(context, state.message);
              }
            } else {
              UtilityWidgets.showSnackBar(context, state.message);
            }
          }
        }, child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Container(
                  height: cheight,
                  width: cwidth,
                  color: const Color(0xff1D2951),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 36.0, bottom: cheight * 0.15),
                          child: const Text(
                            'University Data App',
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontFamily: 'Poweto'),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: 'Poweto'),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, right: 10, bottom: 10),
                              width: cwidth * 0.9,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                border: Border.all(
                                    color: Colors.lightBlueAccent, width: 2),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      autofocus: false,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'GilroySemiBold',
                                          fontSize: 18.0),
                                      controller: _usernameController,
                                      onChanged: (val) => _usernameController
                                        ..text = val
                                        ..selection = TextSelection.collapsed(
                                            offset: _usernameController
                                                .text.length),
                                      //  validator: (val) => isPhoneNumberValid(val) ? null : null,
                                      obscureText: false,
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: "Username",
                                              hintStyle: TextStyle(
                                                  fontFamily: 'GilroySemiBold',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18)),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                  visibilityOb
                                      ? Container(
                                          width: 5,
                                        )
                                      : const Icon(
                                          Icons.check_circle,
                                          size: 22,
                                          color: Color(
                                              0XFF7EE8A9), //Color(0XFF7EE8A9),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Material(
                              color: Colors.white.withOpacity(0.0),
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
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
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () {
                                    _loginBloc.add(UserNameSubmitEvent(
                                        userName: _usernameController.text));
                                  },
                                  child: const Text("Next",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GilroySemiBold',
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (state is LoginLoadingState)
                              const CircularProgressIndicator(
                                color: Colors.white70,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            );
          },
        )));
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image? image;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            color: Colors.cyan,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0,
                offset: Offset(0.0, 20.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 36.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black87)),
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: const Text("Ok",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
