class WagonWord {
  WagonWord({this.guessingWord, this.answer, this.imagePath, this.width, this.disabled});

  WagonWord.loco(this.answer, {this.imagePath = 'assets/images/blueloco.png', this.width = 200, this.disabled = true}) {
    this.guessingWord = this.answer;
  }
  WagonWord.wagon(this.guessingWord, {this.answer = '', this.imagePath = kImagePathWrong, this.width = 200, this.disabled = false});

  String guessingWord;
  String answer;
  String imagePath;
  double width;
  bool disabled;

  static const kImagePathRight = 'assets/images/greenwagon.png';
  static const kImagePathWrong = 'assets/images/bluewagon.png';

  bool isAnswerRight() {
    if (!disabled && answer == guessingWord) {
      imagePath = kImagePathRight;
    } else {
      imagePath = kImagePathWrong;
    }
    return answer == guessingWord;
  }
}
