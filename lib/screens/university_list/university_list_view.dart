import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/common_widgets/utility_widgets.dart';
import 'package:university_app/routes.dart';
import 'package:university_app/screens/university_list/bloc/university_list_bloc.dart';
import 'package:university_app/screens/university_list/bloc/university_list_event.dart';
import 'package:university_app/screens/university_list/bloc/university_list_state.dart';
import 'package:university_app/common_widgets/custom_dialog.dart';
import 'package:university_app/screens/university_list/models/university_model.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';
import 'package:university_app/utils/sharedpreferences_helper.dart';

class UniversityListView extends StatefulWidget {
  const UniversityListView({Key? key}) : super(key: key);

  @override
  _UniversityListViewState createState() => _UniversityListViewState();
}

class _UniversityListViewState extends State<UniversityListView> {
  late UniversityListBloc _universityListBloc;
  final ScrollController _scrollController = ScrollController();
  String? profileImagePath;
  String? userName;
  String? age;

  @override
  void initState() {
    _universityListBloc = UniversityListBloc();
    _universityListBloc.add(UniversityListLoadingEvent());
    getProfilePhotoAndName();
    super.initState();
  }

  getProfilePhotoAndName() async {
    profileImagePath = await SharedpreferencesHelper.getProfilePic();
    userName = await SharedpreferencesHelper.getUserName();
    ProfileModel? profileModel = await SharedpreferencesHelper.getProfileData();
    age = profileModel!.age;
  }

  @override
  void dispose() {
    super.dispose();
    _universityListBloc.close();
  }

  _showDialog(BuildContext context, UniversityModel univData) {
    // return object of type Dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: univData.name ?? 'NA',
        domain: univData.webPages != null ? univData.webPages![0] : 'NA',
        state:
            univData.stateProvince != null && univData.stateProvince != 'null'
                ? univData.stateProvince!
                : 'NA',
        alphaCode:
            univData.alphaTwoCode != null ? univData.alphaTwoCode! : 'NA',
        buttonText: "OK",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cheight = MediaQuery.of(context).size.height;
    double cwidth = MediaQuery.of(context).size.width;

    return BlocProvider<UniversityListBloc>(
        create: (BuildContext context) => _universityListBloc,
        child: BlocListener<UniversityListBloc, UniversityListState>(
            listener: (context, state) async {
          if (state is UniversityListErrorState) {
            UtilityWidgets.showSnackBar(context, state.errorMessage);
          }
        }, child: BlocBuilder<UniversityListBloc, UniversityListState>(
                builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('University List'),
                elevation: 0.0,
                backgroundColor: Colors.blueGrey,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    height: cheight,
                    width: cwidth,
                    color: const Color(0xff1D2951),
                  ),
                  if (state is UniversityListLoadedState)
                    Container(
                      margin: EdgeInsets.only(top: cheight * 0),
                      child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          reverse: false,
                          itemCount: state.univList.length,
                          itemBuilder: (context, index) => Card(
                                elevation: 6.0,
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _showDialog(context, state.univList[index]);
                                  },
                                  child: Container(
                                    height: 115,
                                    width: cwidth * 0.7,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          end: Alignment.topRight,
                                          begin: Alignment.bottomLeft,
                                          colors: [
                                            Color(0XFF5daffa),
                                            Color(0XFF82c2ff)
                                          ]),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Colors.white70,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('S.No. ${index + 1}'),
                                          const SizedBox(height: 5),
                                          Text(
                                            state.univList[index].name ?? 'NA',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text(
                                                'State:',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black87),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                state.univList[index]
                                                                .stateProvince ==
                                                            null ||
                                                        state.univList[index]
                                                                .stateProvince ==
                                                            'null'
                                                    ? 'NA'
                                                    : state.univList[index]
                                                        .stateProvince!,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    )
                  else if (state is UniversityListLoadingState)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white70,
                      ),
                    )
                ],
              ),
            ),
          );
        })));
  }
}
