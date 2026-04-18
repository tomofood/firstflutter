import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hm_demo/api/dio_api.dart';
import 'package:hm_demo/components/custom_text_field.dart';
import 'package:hm_demo/components/loading_widget.dart';
import 'package:hm_demo/providers/token_manager.dart';
import 'package:hm_demo/utils/validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool checkboxValue = false;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double formWidth = screenWidth >= 400 ? 400 : screenWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: formWidth,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text('用户登录', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: usernameController,
                  hintText: '请输入手机号码',
                  validator: mobileValidator,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: passwordController,
                  hintText: '请输入密码',
                  isPassword: true,
                  validator: passwordValidator,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValue,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValue = value!;
                        });
                      },
                    ),
                    Text('请查看并阅读'),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text('《用户协议》'),
                      ),
                    ),
                    Text('和'),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text('《隐私保护》'),
                      ),
                    ),
                  ],
                ),
                if (checkboxValue == false && isSubmitted == true)
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(
                      '请勾选并查看用户协议',
                      style: TextStyle(color: Colors.redAccent, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Consumer(
                    builder: (context, ref, widget) => ElevatedButton(
                      onPressed: () {
                        handleSubmit(ref);
                      },
                      child: Text('提交'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleSubmit(WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      if (checkboxValue == true) {
        Map<String, dynamic> data = {
          'account': usernameController.text,
          'password': passwordController.text,
        };
        try {
          LoadingWidget.show(context, '登录中');
          final result = await loginAPI(data);
          if (result.token != null) {
            await tokenManager.setToken(result.token!, ref);
          }
          if (!mounted) return;
          LoadingWidget.close(context);
          context.pop();
        } catch (e) {
          if (!mounted) return;
          String message = e is DioException ? e.error.toString() : '网络故障';
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(title: Text('提示'), content: Text(message));
            },
          );
        }
      } else {
        setState(() {
          isSubmitted = true;
        });
      }
    }
  }
}
