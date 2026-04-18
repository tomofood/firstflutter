import 'package:hm_demo/api/dio_api.dart';
import 'package:hm_demo/models/user_infos.dart';
import 'package:hm_demo/providers/token_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_infos.g.dart';

@riverpod
class UserInfos extends _$UserInfos {
  @override
  Future<UserInfosModel?> build() async {
    String? token = await tokenManager.getToken();
    if (token == null) return null;
    try {
      return await getUseInfosAPI();
    } catch (e) {
      return null;
    }
  }

  Future<void> refresh() async {
    state = AsyncLoading();
    try {
      final data = await getUseInfosAPI();
      state = AsyncData(data);
    } catch (e) {
      state = AsyncData(null);
    }
  }

  Future<void> clear() async {
    state = AsyncData(null);
  }
}
