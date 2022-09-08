import 'package:delivery/models/response_model.dart';
import 'package:delivery/models/sign_up_body_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:delivery/data/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    late ResponseModel responseModel;
    Response response = await authRepo.registration(signUpBody);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    if (kDebugMode) {
      print('Getting token');
    }
   await authRepo.getUserToken();
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('My token is ${response.body['token']}');
        print('Backend token');
      }
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool getLoggedIn() {
    return authRepo.getLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
