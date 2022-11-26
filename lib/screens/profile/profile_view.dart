import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/common_widgets/utility_widgets.dart';
import 'package:university_app/routes.dart';
import 'package:university_app/screens/profile/bloc/profile_bloc.dart';
import 'package:university_app/screens/profile/bloc/profile_event.dart';
import 'package:university_app/screens/profile/bloc/profile_state.dart';
import 'package:university_app/common_widgets/polkadots_canvas.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';
import 'package:university_app/screens/profile/widgets/modal_sheet.dart';
import 'package:university_app/utils/sharedpreferences_helper.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final bool visibilityOb = true;
  final Color color1 = const Color(0XFF015DEA);
  final Color color2 = const Color(0XFF01C4FA);
  final String _dialogTitle = 'Alert';
  final String _dialogDesc = 'Username already exists, try with other one!';
  final String _dialogButtonText = 'Okay';
  late ProfileBloc _profileBloc;
  late String? profilePhotoPath;

  @override
  void initState() {
    _profileBloc = ProfileBloc();
    _nameController.text = '';
    _ageController.text = '';
    profilePhotoPath = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _profileBloc.close();
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

    return BlocProvider<ProfileBloc>(
        create: (context) => _profileBloc,
        child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) async {
          if (state is ProfileErrorState) {
            UtilityWidgets.showSnackBar(context, state.errorMessage);
            _profileBloc.add(ProfileResetEvent());
          } else if (state is ProfileDataSubmittedState) {
            Navigator.of(context).pushReplacementNamed(Routes.dashboard);
          } else if (state is PickProfilePhotoState) {
            profilePhotoPath = await SharedpreferencesHelper.getProfilePic();
            setState(() {});
          }
        }, child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Scaffold(
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
                              top: 36.0, bottom: cheight * 0.05),
                          child: const Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontFamily: 'Poweto'),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: profilePhotoPath == ''
                                      ? Image.asset('user_avatar2.png',
                                          height: cheight * 0.1,
                                          width: cheight * 0.1)
                                      : Container(
                                          width: cheight * 0.1,
                                          height: cheight * 0.1,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: FileImage(File(
                                                      profilePhotoPath!))))),
                                ),
                                Positioned(
                                  right: 5,
                                  bottom: 1,
                                  child: InkWell(
                                    onTap: () {
                                      modalBottomSheet(context, _profileBloc);
                                    },
                                    child: const Icon(
                                      Icons.camera_enhance,
                                      color: Colors.white70,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
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
                                      controller: _nameController,
                                      onChanged: (val) => _nameController
                                        ..text = val
                                        ..selection = TextSelection.collapsed(
                                            offset:
                                                _nameController.text.length),
                                      obscureText: false,
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: "Name",
                                              hintStyle: TextStyle(
                                                  fontFamily: 'GilroySemiBold',
                                                  color: Colors.white60,
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
                                      controller: _ageController,
                                      onChanged: (val) => _ageController
                                        ..text = val
                                        ..selection = TextSelection.collapsed(
                                            offset: _ageController.text.length),
                                      obscureText: false,
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: "Age",
                                              hintStyle: TextStyle(
                                                  fontFamily: 'GilroySemiBold',
                                                  color: Colors.white60,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18)),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: false),
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
                                    if (_ageController.text != '' &&
                                        _nameController.text != '' &&
                                        profilePhotoPath != '') {
                                      _profileBloc.add(ProfileDataSubmitEvent(
                                          profileModel: ProfileModel(
                                              name: _nameController.text,
                                              age: _ageController.text)));
                                    } else {
                                      _profileBloc.add(ProfileErrorEvent(
                                          errorMessage:
                                              'Please fill all the fields'));
                                    }
                                  },
                                  child: const Text("You're welcome",
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
                            if (state is ProfileLoadingState)
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
