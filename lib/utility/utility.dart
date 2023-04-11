import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utility {
  static void exitFromApp() {
    try {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } catch (e) {
      exit(0);
    }
  }

  static showToast({required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
