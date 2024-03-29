import 'package:delivery/models/sign_up_body_model.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:delivery/data/api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.post(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  bool getLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? 'None';
  }

  Future<Response> login(String email, String password) async {
    return await apiClient
        .post(AppConstants.LOGIN_URI, {'email': email, 'password': password});
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      rethrow;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PHONE);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
