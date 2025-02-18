import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';

const kImagePathWrong = 'assets/images/bluewagon.png';
const kImagePathRight = 'assets/images/greenwagon.png';
const kImageLocomotive = 'assets/images/blueloco.png';

class WagonQuestion {
  String question;
  String guess;
  String answer;
  String imagePath;
  double width;
  bool disabled;

  WagonQuestion({this.question, this.guess, this.answer, this.imagePath, this.width, this.disabled});

  WagonQuestion.loco(this.answer, {this.question, this.imagePath = kImageLocomotive, this.width = 140, this.disabled = true}) {
    answer = answer.trim();
    guess = answer;
  }
  WagonQuestion.wagon(this.guess, {this.question, this.answer = '', this.imagePath = kImagePathWrong, this.width = 150, this.disabled = false}) {
    guess = guess.trim();
  }

  ///
  bool _loco;
  bool get loco => (imagePath == kImageLocomotive);
  set loco(bool newValue) {
    _loco = newValue;
    disabled = _loco;
    answer = guess;

    if (_loco) imagePath = kImageLocomotive;
  }

  bool goodAnswer() {
    if (disabled) return false;

    if (answer == guess) {
      imagePath = kImagePathRight;
      disabled = true;
      AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundTrainSifflement));
    } else {
      imagePath = kImagePathWrong;
    }

    return answer == guess;
  }
}
