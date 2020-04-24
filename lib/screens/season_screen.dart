import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../providers/app_provider.dart';

class SeasonScreen extends StatefulWidget {
  SeasonScreen({Key key, this.title}) : super(key: key);
  static const routeName = '/home';
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
            itemCount: 15,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                  ),
                  child: Center(
                    child: Text('${index + 1}'),
                  ),
                ),
                onTap: () {
                  if (mounted) {
                    setState(() {
                      print(index);
                    });
                  }
                },
              );
            }),
      ),
    );
  }
}
