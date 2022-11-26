import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_app/screens/profile/bloc/profile_bloc.dart';
import 'package:university_app/screens/profile/bloc/profile_event.dart';

modalBottomSheet(BuildContext context, ProfileBloc _profileBloc) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Profile Photo",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      // Expanded(
                      //   flex: 1,
                      //   child: Column(
                      //     children: <Widget>[
                      //       Material(
                      //           color: Colors.white,
                      //           child: InkWell(
                      //             onTap: () {
                      //               int imagecheck = 1;
                      //               getImage(imagecheck);
                      //               Navigator.of(context).pop();
                      //             },
                      //             child: Icon(
                      //               Icons.camera_enhance,
                      //               size: 45,
                      //               color: Colors.blue[300],
                      //             ),
                      //           )),
                      //       Text(
                      //         "Camera",
                      //         textAlign: TextAlign.left,
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.blue[300]),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    _profileBloc.add(PickProfilePhotoEvent());
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.perm_media,
                                    size: 45,
                                    color: Colors.blue[300],
                                  ),
                                )),
                            Text(
                              "Gallery",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[300]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ],
          );
        });
      });
}
