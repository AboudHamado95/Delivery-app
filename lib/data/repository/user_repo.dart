import 'package:delivery/data/api/api_client.dart';
import 'package:delivery/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future getUserInfo() async {
    await apiClient.getData(AppConstants.USER_INFO);
  }
}
