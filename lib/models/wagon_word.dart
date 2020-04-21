import 'package:audioplayers/audio_cache.dart';

const kImagePathWrong = 'assets/images/bluewagon.png';
const kImagePathRight = 'assets/images/greenwagon.png';
const kImageLocomotive = 'assets/images/blueloco.png';

class WagonWord {
  WagonWord({this.guessingWord, this.answer, this.imagePath, this.width, this.disabled});

  WagonWord.loco(this.answer, {this.imagePath = kImageLocomotive, this.width = 140, this.disabled = true}) {
    this.guessingWord = this.answer;
    initPlayer();
  }
  WagonWord.wagon(this.guessingWord, {this.answer = '', this.imagePath = kImagePathWrong, this.width = 150, this.disabled = false}) {
    initPlayer();
  }

  String guessingWord;
  String answer;
  String imagePath;
  double width;
  bool disabled;

  AudioCache soundEffect;

  bool _loco;
  bool get loco => (imagePath == kImageLocomotive);
  set loco(bool newValue) {
    _loco = newValue;
    disabled = _loco;
    answer = guessingWord;

    if (_loco) imagePath = kImageLocomotive;
  }

  bool isAnswerRight() {
    if (disabled) return false;

    if (answer == guessingWord) {
      imagePath = kImagePathRight;
      disabled = true;
      soundEffect.play('sounds/sifflement.mp3');
    } else {
      imagePath = kImagePathWrong;
    }

    return answer == guessingWord;
  }

  void initPlayer() {
    soundEffect = AudioCache();
  }
}
