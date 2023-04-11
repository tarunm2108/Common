import 'dart:async';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_code/app_consts/app_colors.dart';
import 'package:my_code/app_consts/extension/text_style_extension.dart';
class AppBaseController extends GetxController {
  bool _isBusy = false;
  DateTime? currentBackPressTime;

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  double getFileSize(File image) {
    final bytes = image.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    return kb / 1024;
  }

  Color getStringToColor({required String? hexColor}) {
    try {
      final color = hexColor?.replaceAll('#', '');
      return Color(int.parse('0xff$color'));
    } catch (e) {
      return Colors.white;
    }
  }

  void commonDatePicker({
    required DateTime selectedDate,
    required Function(DateTime selectDate) onDateSelection,
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    showDatePicker(
      context: Get.context!,
      builder: (c, child) {
        return Theme(
          data: Theme.of(c).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: selectedDate,
      firstDate: minDate ??
          DateTime.now().subtract(
            const Duration(
              days: 365,
            ),
          ),
      lastDate: maxDate ?? DateTime.now(),
      helpText: 'Select Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
    ).then((pickedDate) {
      if (pickedDate != null) {
        onDateSelection(pickedDate);
      }
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast(msg: 'Tap Back button again for exit app');
      return Future.value(false);
    }
    return Future.value(true);
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(
      firstDayThisMonth.year,
      firstDayThisMonth.month + 1,
      firstDayThisMonth.day,
    );
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  bool checkValidFromToTime(
      {required TimeOfDay fromTime, required TimeOfDay toTime}) {
    DateTime fromDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      fromTime.hour,
      fromTime.minute,
    );
    DateTime toDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      toTime.hour,
      toTime.minute,
    );
    if (toDate.isAfter(fromDate)) {
      return true;
    } else {
      return false;
    }
  }

  String durationToTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String formatDate(String date, String format, String expectFormat,
      {bool? isUtc}) {
    if (date.isEmpty || date.toLowerCase() == 'null') {
      return DateFormat(expectFormat).format(DateTime.now().toLocal());
    }
    DateTime parse = DateFormat(format).parse(date, isUtc ?? false);
    return DateFormat(expectFormat).format(parse.toLocal());
  }

  Color getColorFromHex(String? value) {
    if (value?.isNotEmpty ?? false) {
      final colorCode = value!.toString().replaceAll('#', '');
      return Color(int.parse('0xff$colorCode'));
    } else {
      return Colors.transparent;
    }
  }

  void showLoader() {
    Get.dialog(
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
          color: Colors.transparent,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
              strokeWidth: 3,
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      useSafeArea: true,
    );
  }

  void exitFromApp() {
    try {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } catch (e) {
      exitFromApp();
    }
  }

  void back({result}) {
    Get.back(result: result);
  }

  void hideDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  void showToast({required String msg, Duration? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        message: msg,
        duration: duration ??
            const Duration(
              seconds: 2,
            ),
      ),
    );
  }

  void showCountryList(BuildContext context, Function(Country c) onDone) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle().regular,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Search',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          isDense: false,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: onDone,
    );
  }

  void showLogoutDialog() {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text(
            "Logout",
            style: const TextStyle().bold,
          ),
          content: Text(
            "Are you want to logout from App?",
            style: const TextStyle().regular,
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                "NO",
                style: const TextStyle().bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                "YES",
                style: const TextStyle().bold,
              ),
            ),
          ],
        );
      },
    );
  }

  /*Future<String> getDeviceToken() async {
    try {
      final value = SharedPre.getStringValue(
        SharedPre.deviceToken,
        defaultValue: '',
      );
      if (value.isNotEmpty) {
        return value;
      } else {
        final token = await FirebaseMessaging.instance.getToken();
        return token ?? 'token';
      }
    } catch (e) {
      return 'token';
    }
  }*/

  Future<XFile?> pickImage() async {
    return await Get.bottomSheet<XFile>(
      CupertinoActionSheet(
        title: const Text("Select a option"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              XFile? file = await _actionPickImage(ImageSource.camera);
              back(result: file);
            },
            child: Text(
              "From Camera",
              style: const TextStyle().regular.copyWith(
                    color: Colors.purple,
                    fontSize: 15,
                  ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              XFile? file = await _actionPickImage(ImageSource.gallery);
              back(result: file);
            },
            child: Text(
              "From Gallery",
              style: const TextStyle().regular.copyWith(
                    color: Colors.purple,
                    fontSize: 15,
                  ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            back();
          },
          child: Text(
            "Cancel",
            style: const TextStyle().regular.copyWith(
                  color: Colors.purple,
                  fontSize: 15,
                ),
          ),
        ),
      ),
    );
  }

  Future<XFile?> _actionPickImage(ImageSource imageSource) async {
    // Pick an image
    return ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 30,
    );
  }

  void textCopy({required String text}) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    showToast(msg: 'Text copied');
  }

  void setBusy(bool isBusy) {
    _isBusy = isBusy;
    update();
  }

  bool get isBusy => _isBusy;
}
