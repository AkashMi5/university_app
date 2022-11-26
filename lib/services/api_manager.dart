import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:university_app/screens/university_list/models/university_model.dart';
import 'package:university_app/screens/login/models/user_login.dart';
import 'package:university_app/services/api_exception.dart';
import 'package:university_app/services/db_provider.dart';

class ApiManager {
  final String _baseUrl = "http://avenirtechs.com/TriviaApp/triviacontroller/";
  DBProvider database = DBProvider.db;

  Future<dynamic> addUser(String username, String deviceid) async {
    try {
      final addUserResponse = await http.post(Uri.parse(_baseUrl + 'add_user'),
          body: {
            'username': username,
            'deviceid': deviceid
          }).timeout(const Duration(seconds: 10));

      if (addUserResponse.statusCode == 200) {
        var resbody = json.decode(addUserResponse.body);
        if (resbody['mssg'] == 'user data inserted successfully') {
          var userjson = resbody['data'];

          UserLogin userData = UserLogin.fromJson(userjson);
          return userData;
        } else if (resbody['mssg'] == 'Login successful') {
          var userjson = resbody['data'];

          UserLogin userData = UserLogin.fromJson(userjson);
          return userData;
        } else if (resbody['mssg'] == 'username taken by someone else') {
          return 'Username taken by someone else';
        } else {
          return 'Some error occurred';
        }
      } else {
        _returnResponse(addUserResponse);
      }
    } on SocketException catch (e) {
      return FetchDataException('No Internet connection');
    } on TimeoutException catch (_) {
      return FetchDataException('No Internet connection');
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getUniversityData() async {
    try {
      final getUnivData = await http
          .get(
            Uri.parse('http://universities.hipolabs.com/search?country=India'),
          )
          .timeout(const Duration(seconds: 10));

      if (getUnivData.statusCode == 200) {
        var univData = json.decode(getUnivData.body);

        List<UniversityModel> univList = [];
        for (int i = 0; i < univData.length; i++) {
          UniversityModel univ = UniversityModel.fromJson(univData[i]);
          univList.add(univ);
        }

        await database.deleteAll();
        await database.insertAll(univList);

        return univList;
      } else {
        _returnResponse(getUnivData);
      }
    } catch (e) {
      return e.toString();
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 400:
      case 404:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
