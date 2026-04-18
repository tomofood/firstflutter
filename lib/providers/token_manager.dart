import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_demo/providers/user_infos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  final asyncPrefs = SharedPreferencesAsync();
  final tokenName = 'token';
  Future<String?> getToken() async {
    return await asyncPrefs.getString(tokenName);
  }

  Future<void> setToken(String token, WidgetRef ref) async {
    await asyncPrefs.setString(tokenName, token);
    await ref.read(userInfosProvider.notifier).refresh();
  }

  Future<void> removeToken(WidgetRef ref) async {
    await asyncPrefs.remove(tokenName);
    await ref.read(userInfosProvider.notifier).clear();
  }
}

final tokenManager = TokenManager();
