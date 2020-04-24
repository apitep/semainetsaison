import 'package:flutter/material.dart';

import '../models/season.dart';

class SeasonCard extends StatefulWidget {
  SeasonCard({Key key, @required this.season, @required this.nbSuccess}) : super(key: key);

  final Season season;
  final ValueNotifier<int> nbSuccess;

  @override
  _SeasonCardState createState() => _SeasonCardState();
}

class _SeasonCardState extends State<SeasonCard> {
  double wordContainerHeight = 150;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wordContainerHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.season.url),
          fit: BoxFit.cover,
        ),
      ),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.season.months.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: Text(
            widget.season.months[index],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
