import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

const kImagePathWrong = 'assets/images/bluewagon.png';
const kImagePathRight = 'assets/images/greenwagon.png';
const kImageLocomotive = 'assets/images/blueloco.png';

class WagonWord {
  WagonWord({this.guessingWord, this.answer, this.imagePath, this.width, this.disabled});

  WagonWord.loco(this.answer, {this.imagePath = kImageLocomotive, this.width = 170, this.disabled = true}) {
    this.guessingWord = this.answer;
    initPlayer();
  }
  WagonWord.wagon(this.guessingWord, {this.answer = '', this.imagePath = kImagePathWrong, this.width = 180, this.disabled = false}) {
    initPlayer();
  }

  String guessingWord;
  String answer;
  String imagePath;
  double width;
  bool disabled;

  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  bool isAnswerRight() {
    if (disabled) return false;

    if (answer == guessingWord) {
      imagePath = kImagePathRight;
      disabled = true;
      audioCache.play('sounds/sifflement.mp3');
    } else {
      imagePath = kImagePathWrong;
    }

    return answer == guessingWord;
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }
}
