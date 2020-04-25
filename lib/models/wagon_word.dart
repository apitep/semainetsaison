import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';

const kImagePathWrong = 'assets/images/bluewagon.png';
const kImagePathRight = 'assets/images/greenwagon.png';
const kImageLocomotive = 'assets/images/blueloco.png';

class WagonWord {
  String guessingWord;
  String answer;
  String imagePath;
  double width;
  bool disabled;

  WagonWord({this.guessingWord, this.answer, this.imagePath, this.width, this.disabled});

  WagonWord.loco(this.answer, {this.imagePath = kImageLocomotive, this.width = 140, this.disabled = true}) {
    this.answer = this.answer.trim();
    this.guessingWord = this.answer;
  }
  WagonWord.wagon(this.guessingWord, {this.answer = '', this.imagePath = kImagePathWrong, this.width = 150, this.disabled = false}) {
    this.guessingWord = this.guessingWord.trim();
  }

  ///
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
      AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundTrainSifflement));
    } else {
      imagePath = kImagePathWrong;
    }

    return answer == guessingWord;
  }
}
