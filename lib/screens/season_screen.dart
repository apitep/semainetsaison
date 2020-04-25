import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../providers/app_provider.dart';

class SeasonScreen extends StatefulWidget {
  SeasonScreen({Key key, this.title}) : super(key: key);
  static const routeName = '/season';
  final Key key = UniqueKey();
  final String title;

  @override
  _SeasonScreenState createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> {
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
      body: Center(
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: appProvider.seasons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
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
              );
            }),
      ),
    );
  }
}
