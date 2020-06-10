import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';

class SoundController extends RxController {
  FlutterTts flutterTts;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  static const String kDeviceNotFound = "Device not found";
  static const String kLookingForDevice = "Looking for MySID device: ";

  final Color bgColor = Color(0xffd4d9d2);
  final Color statusColor = Color(0xff80817c);
  final Color txtColor = Color(0xff3a3a3a);

  static const String SERVICE_UUID = "042bd80f-14f6-42be-a45c-a62836a4fa3f";
  static const String SENSORS_CHARACTERISTIC_UUID = "065de41b-79fb-479d-b592-47caf39bfccb";
  static const String MOTOR_CHARACTERISTIC_UUID = "1447ca05-5e42-4bcd-bff3-68e1dae982ca";

  final isMusicPlaying = false.obs;
  final recordData = true.obs;
  final connectionText = ''.obs;
  final deviceName = ''.obs;

  final pressure = ''.obs;

  final readyToPlaceSyringe = false.obs;
  final syringeInPlace = false.obs;
  final primingDone = false.obs;

  @override
  onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //-------------------------------------
  void init() {
    initPlayer();
    initTts();
    musicBackground(true);
    ever(
      connectionText,
      (_) => Get.snackbar(
        'Syringe Bluetooth Controller',
        connectionText.value,
        icon: Icon(Icons.bluetooth),
        shouldIconPulse: true,
        barBlur: 10,
        isDismissible: true,
        duration: Duration(seconds: 4),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }

  void initTts() async {
    if (GetPlatform.isMacOS) return;

    flutterTts = FlutterTts();
    flutterTts.setLanguage('fr-FR');
    await flutterTts.isLanguageAvailable('fr-FR');
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts = FlutterTts();
  }

  void initPlayer() {
    assetsAudioPlayer.open(Audio(Constants.kBackgroundAudioLow));
    assetsAudioPlayer.loop = true;
  }

  void speak(String textToSpeak) async {
    await flutterTts.speak(textToSpeak);
  }

  void musicBackground(bool play) {
    play ? assetsAudioPlayer.play() : assetsAudioPlayer.pause();
    isMusicPlaying.value = play;
  }
}
