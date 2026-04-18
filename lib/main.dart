import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_demo/routes/index.dart';

void main(List<String> args) {
  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'HM SHOP',
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.greenAccent.shade100,
          ),
        ),
      ),
    ),
  );
}
