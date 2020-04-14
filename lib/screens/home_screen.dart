import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../providers/app_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppProvider appProvider;
  final options = LiveOptions(
    delay: Duration(milliseconds: 200),
    showItemInterval: Duration(milliseconds: 200),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Constants.kColorLightGreen,
      appBar: topBar(context, Constants.kTitle),
      body: Center(
        child: LiveGrid.options(
          options: options,
          itemBuilder: buildAnimatedItem,
          itemCount: appProvider.stories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>

      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: Card(
            elevation: 4.0,
            margin: EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
              child: InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Center(child:	Image.network(appProvider.stories[index].thumbUrl)),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(appProvider.stories[index].title, style: TextStyle(fontSize: 18.0, color: Colors.black)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
