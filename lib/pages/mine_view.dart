import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hm_demo/models/user_infos.dart';
import 'package:hm_demo/providers/token_manager.dart';
import 'package:hm_demo/providers/user_infos.dart';

class MineView extends ConsumerWidget {
  const MineView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfos = ref.watch(userInfosProvider);
    return Card(
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: userInfos.when(
            data: (data) {
              if (data == null) {
                return NotLoggedWidget();
              } else {
                return LoggedInWidget(userInfos: data);
              }
            },
            error: (error, stack) => NotLoggedWidget(),
            loading: () => LoadingWidget(),
          ),
        ),
      ),
    );
  }
}

class NotLoggedWidget extends StatelessWidget {
  const NotLoggedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/mine/ic_user_vip.png'),
          radius: 40,
        ),
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: TextButton(
            onPressed: () {
              context.push('/login');
            },
            child: Text(
              '立即登录',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

class LoggedInWidget extends StatelessWidget {
  final UserInfosModel userInfos;
  const LoggedInWidget({super.key, required this.userInfos});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(userInfos.avatar),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(userInfos.account),
                Consumer(
                  builder: (context, ref, widget) => TextButton(
                    onPressed: () {
                      handleLogout(ref);
                    },
                    child: Text('退出登录'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void handleLogout(WidgetRef ref) async {
    await tokenManager.removeToken(ref);
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40, width: 40, child: CircularProgressIndicator());
  }
}
