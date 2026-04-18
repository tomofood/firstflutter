import 'package:hm_demo/constants/index.dart';
import 'package:hm_demo/models/user_infos.dart';
import 'package:hm_demo/utils/dio_client.dart';

Future<UserInfosModel> loginAPI(Map<String, dynamic> data) async {
  final path = HttpConstants.login;
  final response = await dioClient.post(path, data);
  return UserInfosModel.fromJson(response);
}

Future<UserInfosModel> getUseInfosAPI() async {
  final path = HttpConstants.token;
  final result = await dioClient.get(path);
  return UserInfosModel.fromJson(result as Map<String, dynamic>);
}
