import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_code/src/ui/player/common_slider.dart';
import 'package:video_player/video_player.dart';

enum VideoType { file, network, assets }

class VideoPlayerView extends StatefulWidget {
  final String videoUrl;
  final VideoType videoType;

  const VideoPlayerView({
    required this.videoUrl,
    required this.videoType,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController? controller;
  bool _isFullscreen = false;

  @override
  void initState() {
    setLandscape().then((value) {
      if (widget.videoType == VideoType.network) {
        controller = VideoPlayerController.network(widget.videoUrl)
          ..addListener(() => setState(() {}))
          ..setLooping(false)
          ..setVolume(1)
          ..initialize().then((_) => controller?.play());
      } else {
        controller = VideoPlayerController.file(File(widget.videoUrl))
          ..addListener(() => setState(() {}))
          ..setLooping(false)
          ..setVolume(1)
          ..initialize().then((_) => controller?.play());
      }
    });
    super.initState();
  }

  @override
  void dispose() async {
    controller?.dispose();
    await setAllOrientations();
    super.dispose();
  }

  Future setLandscape() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true));
    /*await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);*/
  }

  Future setAllOrientations() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: controller?.value.isInitialized ?? false
            ? Container(alignment: Alignment.topCenter, child: buildVideo())
            : const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              )),
      );

  Widget buildVideo() => OrientationBuilder(builder: (context, orientation) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            buildVideoPlayer(),
            _basicOverlayWidget(controller),
          ],
        );
      });

  Widget buildVideoPlayer() => buildFullScreen(
        AspectRatio(
          aspectRatio: controller?.value.aspectRatio ?? 0,
          child: VideoPlayer(controller!),
        ),
      );

  Widget buildFullScreen(Widget child) {
    final size = controller?.value.size;
    final width = size?.width;
    final height = size?.height;

    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(width: width, height: height, child: child),
    );
  }

  Widget _basicOverlayWidget(VideoPlayerController? controller) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller?.value.isPlaying ?? false
          ? controller?.pause()
          : controller?.play(),
      child: Stack(
        children: <Widget>[
          buildPlay(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                color: Colors.black12,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: SeekBar(
                        duration: controller?.value.duration ?? Duration.zero,
                        position: controller?.value.position ?? Duration.zero,
                        bufferedPosition: _getBufferingDuration(),
                        onChangeEnd: (d) {
                          controller?.seekTo(d);
                        },
                        textColor: Colors.white,
                      ),
                    ),
                    IconButton(
                        onPressed: () => _fullscreenOnOff(),
                        icon: Icon(
                          _isFullscreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                        ))
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _fullscreenOnOff() {
    setState(() {
      _isFullscreen = !_isFullscreen;
      if (_isFullscreen) {
        AutoOrientation.landscapeRightMode();
        _hideStatusBar(true);
      } else {
        AutoOrientation.portraitUpMode();
        _hideStatusBar(false);
      }
    });
  }

  void _hideStatusBar(bool value) {
    if (value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  Duration _getBufferingDuration() {
    if (controller != null) {
      int maxBuffering = 0;
      for (DurationRange range in controller!.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }
      return Duration(milliseconds: maxBuffering);
    } else {
      return Duration.zero;
    }
  }

  Widget buildIndicator() => VideoProgressIndicator(
        controller!,
        allowScrubbing: true,
        colors: const VideoProgressColors(
            backgroundColor: Colors.white38,
            bufferedColor: Colors.white,
            playedColor: Colors.blueAccent),
      );

  Widget buildPlay() => controller?.value.isPlaying ?? false
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: AppBar(
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
              ),
              const Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                      child: Icon(Icons.play_arrow,
                          color: Colors.white, size: 80))),
            ],
          ),
        );
}
