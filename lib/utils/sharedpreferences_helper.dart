import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_app/screens/profile/models/profile_model.dart';

class SharedpreferencesHelper {
  static Future<String?> getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('deviceId');
  }

  static Future<bool> setDeviceId(String deviceId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString('deviceId', deviceId);
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('userId');
  }

  static Future<bool> setUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString('userId', userId);
  }

  static Future<bool> setUserName(String uname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString('userName', uname);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('userName');
  }

  static Future<bool> setProfileData(ProfileModel profileData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String profileJson = jsonEncode(profileData);
    return prefs.setString('profileData', profileJson);
  }

  static Future<ProfileModel?> getProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('profileData')) {
      Map<String, dynamic> jsonData =
          jsonDecode(prefs.getString('profileData') ?? '');
      return ProfileModel.fromJson(jsonData);
    } else {
      return null;
    }
  }

  static Future<bool> checkProfileDataKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('profileData');
  }

  static Future<bool> clearSP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }

  static Future<bool> checkUserIdKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('userId');
  }

  static Future<bool> setProfilePic(String picFile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString('profilePic', picFile);
  }

  static Future<String?> getProfilePic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('profilePic');
  }
}
