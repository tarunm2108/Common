import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_code/app_consts/extension/text_style_extension.dart';
import 'package:my_code/src/ui/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) => Scaffold(
        body: Center(
          child: Text(
            "Splash Screen",
            style: const TextStyle().bold,
          ),
        ),
      ),
      init: SplashController(),
    );
  }

  Widget _noInternet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 50,
          ),
          Text(
            "Please check your internet connection",
            style: const TextStyle().bold,
          ),
        ],
      ),
    );
  }
}
