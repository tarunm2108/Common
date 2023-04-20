import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_code/src/base/base_controller.dart';

class AudioPlayerModel extends AppBaseController {
  final AudioPlayer player = AudioPlayer();
  PlaybackEvent? positionData;
  Duration _position = Duration.zero;
  AudioPlayerArg? arg;

  @override
  void onInit() {
    arg = Get.arguments as AudioPlayerArg;
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      player.positionStream.listen((event) {
        //print('____ positionStream ${event.inSeconds}');
        position = event;
      });
      await player
          .setAudioSource(AudioSource.uri(Uri.parse(arg?.fileUrl ?? '')));
      player.play().then((value) => update());
    } catch (e) {
      debugPrint("____Error loading audio source: $e");
    }
    super.onReady();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Duration get position => _position;

  set position(Duration value) {
    _position = value;
    update();
  }
}

class AudioPlayerArg {
  String? fileUrl;
  String? thumbnailUrl;

  AudioPlayerArg({required this.fileUrl, required this.thumbnailUrl});
}
