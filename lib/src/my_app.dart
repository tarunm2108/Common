import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_code/app_consts/app_colors.dart';
import 'package:my_code/app_consts/constants.dart';
import 'package:my_code/app_route/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:

        break;
      case AppLifecycleState.inactive:

        break;
      case AppLifecycleState.paused:

        break;
      case AppLifecycleState.detached:

        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Theme.of(context).copyWith(
        primaryColor: AppColors.primaryColor,
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(backgroundColor: AppColors.primaryColor),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: AppColors.primaryColor,
            ),
        radioTheme: Theme.of(context).radioTheme.copyWith(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.purple),
            ),
      ),
    );
  }
}