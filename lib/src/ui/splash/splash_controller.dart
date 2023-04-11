
import 'package:get/get.dart';
import 'package:my_code/service/firebase_service.dart';
import 'package:my_code/src/base/base_controller.dart';


class SplashController extends AppBaseController {

  @override
  Future<void> onReady() async {

    await FBNotification.instance.init();

  }
}
