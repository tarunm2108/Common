import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_code/src/ui/camera_view/camera_controllerl.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key}) : super(key: key);

  //CameraController controller;
  //CameraView(this.controller);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraViewController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: controller.cameraController.value.isInitialized
              ? _cameraPreviewWidget(context, controller)
              : Container(),
        ),
      ),
      init: CameraViewController(),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget(
    BuildContext context,
    CameraViewController controller,
  ) {
    return Listener(
      //  onPointerDown: (_) => _pointers++,
      //onPointerUp: (_) => _pointers--,
      child: Stack(
        children: [
          SizedBox(
            height: context.height,
            width: context.width,
            child: controller.cameraController.value.isInitialized
                ? CameraPreview(
                    controller.cameraController,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          //onScaleStart: _handleScaleStart,
                          //onScaleUpdate: _handleScaleUpdate,
                          //onTapDown: (details) => onViewFinderTap(details, constraints),
                        );
                      },
                    ),
                  )
                : Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _captureControlRowWidget(controller),
          )
        ],
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget(CameraViewController controller) {
    // final CameraController? cameraController = controller;
    return Container(
      height: 100,
      color: Colors.white.withOpacity(.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Center(
              child: IconButton(
                  onPressed: () => controller.onCancel(),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.blue,
                  )),
            ),
          ),
          controller.cameraController.value.isPreviewPaused
              ? Container()
              : Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.camera),
                      color: Colors.blue,
                      onPressed: () => controller.onTakePictureButtonPressed(),
                    ),
                  ),
                ),
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: controller.cameraController.value.isPreviewPaused
                  ? Colors.white
                  : Colors.transparent,
            ),
            child: controller.cameraController.value.isPreviewPaused
                ? Center(
                    child: IconButton(
                        onPressed: () {
                          Get.back(result: controller.imageFile!.path);
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.blue,
                        )),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ),

          /*IconButton(
            icon: const Icon(Icons.pause_presentation),
            color:
                cameraController != null && cameraController.value.isPreviewPaused
                    ? Colors.red
                    : Colors.blue,
            onPressed:
                cameraController == null ? null : onPausePreviewButtonPressed,
          ),*/
        ],
      ),
    );
  }
}
