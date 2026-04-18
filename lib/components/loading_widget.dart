import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingWidget {
  static void show(BuildContext context, String? content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(content ?? '加载中'), Text('...')],
          ),
        );
      },
    );
  }

  static void close(BuildContext context) {
    context.pop();
  }
}
