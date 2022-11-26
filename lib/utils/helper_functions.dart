import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

setDeviceOrientationPortraitOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

Future<bool> checkNetworkConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return Future.value(true);
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}
