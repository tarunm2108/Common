import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:my_code/src/base/base_controller.dart';

class CameraViewController extends AppBaseController {
  List<CameraDescription> cameras = [];
  late CameraController cameraController;
  XFile? _imageFile;

  @override
  Future<void> onInit() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    super.onInit();
  }

  @override
  void onReady()  {
    cameraController.initialize().then((_) {
      update();
    });
    super.onReady();
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) async {
      if (file != null) {
        imageFile = file;
        await cameraController.pausePreview();
        update();
      }
    });
  }

  Future<XFile?> takePicture() async {
    try {
      if (!cameraController.value.isInitialized
          || cameraController.value.isTakingPicture) {
        //Util.showToast("Error: select a camera first.");
        return null;
      }
      return await cameraController.takePicture();
    } on CameraException catch (e) {
      log(e.code, error: e.description);
      return null;
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> resumeMyCamera() async {
    if (cameraController.value.isInitialized
        && cameraController.value.isPreviewPaused) {
      await cameraController.resumePreview();
     update();
    }
  }

  XFile? get imageFile => _imageFile;

  set imageFile(XFile? value) {
    _imageFile = value;
    update();
  }

  Future<void> onCancel() async {
    if (cameraController.value.isPreviewPaused) {
      imageFile = null;
      await cameraController.resumePreview();
      update();
    } else {
      Get.back(result: "");
    }
  }
}
