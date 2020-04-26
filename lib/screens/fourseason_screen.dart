import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/story.dart';
import '../widgets/topbar.dart';
import '../providers/app_provider.dart';

class FourSeasonScreen extends StatefulWidget {
  FourSeasonScreen({Key key, this.story}) : super(key: key);
  static const routeName = '/season';
  final Key key = UniqueKey();

  final Story story;

  @override
  _FourSeasonScreenState createState() => _FourSeasonScreenState();
}

class _FourSeasonScreenState extends State<FourSeasonScreen> {
  AppProvider appProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      appBar: topBar(context, Constants.kTitle),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: appProvider.seasons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(appProvider.seasons[index].url),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              constraints: BoxConstraints.expand(height: 25),
                              color: Colors.white.withOpacity(0.6),
                              child: Center(
                                child: Text(
                                  '${appProvider.seasons[index].name}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DragTarget(
                            onWillAccept: (data) {
                              return true;
                            },
                            onAccept: (String data) {
                              print(data);
                              print(appProvider.seasons[index].name);
                            },
                            builder: (context, List<String> cd, rd) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DottedBorder(
                                  padding: const EdgeInsets.all(2.0),
                                  strokeWidth: 1,
                                  child: Container(
                                    height: 25,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              );
                            },
                          ),
                          DragTarget(
                            onWillAccept: (data) {
                              return true;
                            },
                            onAccept: (String data) {
                              print(data);
                              print(appProvider.seasons[index].name);
                            },
                            builder: (context, List<String> cd, rd) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DottedBorder(
                                  padding: const EdgeInsets.all(2.0),
                                  strokeWidth: 1,
                                  child: Container(
                                    height: 25,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              );
                            },
                          ),
                          DragTarget(
                            onWillAccept: (data) {
                              return true;
                            },
                            onAccept: (String data) {
                              print(data);
                              print(appProvider.seasons[index].name);
                            },
                            builder: (context, List<String> cd, rd) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DottedBorder(
                                  padding: const EdgeInsets.all(2.0),
                                  strokeWidth: 1,
                                  child: Container(
                                    height: 25,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Constants.months.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.15,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Draggable(
                  data: Constants.months[index],
                  feedback: Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text(
                          '${Constants.months[index]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text(
                          '${Constants.months[index]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
