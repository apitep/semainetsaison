import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../../constants.dart';
import '../../controllers/app_controller.dart';
import '../../models/season.dart';
import '../../models/month.dart';

// ignore: must_be_immutable
class TargetMonth extends StatefulWidget {
  final Offset initPos;
  final Season season;
  final int monthIndex;
  final ValueNotifier<int> nbSuccess;
  bool done = false;

  TargetMonth({this.initPos, @required this.season, @required this.monthIndex, @required this.nbSuccess});

  @override
  TargetMonthState createState() => TargetMonthState();
}

class TargetMonthState extends State<TargetMonth> {
  Offset position = Offset(0.0, 0.0);
  int dragMonthIndex = 0;
  Color itemColor;
  Color overColor;

  @override
  void initState() {
    super.initState();
    overColor = Colors.green.withOpacity(0.7);
    itemColor = Colors.white.withOpacity(0.1);
    widget.done = false;
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {

    return DragTarget(
      onWillAccept: (data) {
        return !widget.done;
      },
      onAccept: (Month data) {
        if (data.name == widget.season.months[widget.monthIndex]) {
          AppController.to.months.singleWhere((item) {
            return (item.name == data.name);
          }).successful = true;
          widget.nbSuccess.value++;
          widget.done = true;
          itemColor = Colors.green.withOpacity(0.7);
          AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundGood));
        }
        dragMonthIndex = AppController.to.months.indexOf(data);
      },
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: DottedBorder(
            padding: const EdgeInsets.all(2.0),
            strokeWidth: 1,
            child: Container(
              width: 130,
              height: 25,
              color: accepted.isEmpty
                  ? (AppController.to.months.singleWhere((item) {
                      return (item.name == widget.season.months[widget.monthIndex]);
                    }).successful
                      ? overColor
                      : itemColor)
                  : overColor,
              child: Text(
                AppController.to.months.singleWhere((item) {
                  return (item.name == widget.season.months[widget.monthIndex]);
                }).successful
                    ? '${widget.season.months[widget.monthIndex]}'
                    : '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates'),
              ),
            ),
          ),
        );
      },
    );
  }
}
