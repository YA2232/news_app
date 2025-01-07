import 'package:flutter/material.dart';
import 'package:news_app/approuting.dart';
import 'package:news_app/constant/string.dart';

void main() {
  runApp(MyApp(approuting: Approuting()));
}

class MyApp extends StatelessWidget {
  final Approuting approuting;
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  const MyApp({super.key, required this.approuting});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: homeScreen,
      onGenerateRoute: approuting.generateRouter,
      navigatorObservers: [routeObserver],
    );
  }
}
