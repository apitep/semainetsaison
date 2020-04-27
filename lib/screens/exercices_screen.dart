import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auto_animated/auto_animated.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../widgets/responsive_widget.dart';
import '../providers/app_provider.dart';
import '../screens/home_screen.dart';
import '../screens/fourseason_screen.dart';
import '../screens/trains/train_screen.dart';
import '../screens/trains/seasons_train_screen.dart';
import '../screens/rightorder_screen.dart';

const kExerciceNames = ["L'ordre des jours", "L'ordre des mois", "Le train des jours", "Le train des mois", "Le train des saisons", "Les 4 saisons"];
const kExerciceColors = [Colors.amber, Colors.blue, Colors.brown, Colors.green, Colors.pink, Colors.purple];

class ExercicesScreen extends StatefulWidget {
  ExercicesScreen({Key key, this.title}) : super(key: key);
  static const routeName = '/exercices';
  final Key key = UniqueKey();
  final String title;

  @override
  _ExercicesScreenState createState() => _ExercicesScreenState();
}

class _ExercicesScreenState extends State<ExercicesScreen> {
  AppProvider appProvider;
  int _currentIndex = 0;
  var exerciceRoutes = [];

  final options = LiveOptions(
    delay: Duration(milliseconds: 50),
    showItemInterval: Duration(milliseconds: 100),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    exerciceRoutes = [
      RightOrderScreen(story: appProvider.randomStory, rightOrder: Constants.days),
      RightOrderScreen(story: appProvider.randomStory, rightOrder: Constants.months),
      TrainScreen(story: appProvider.randomStory, wagons: Constants.days,),
      TrainScreen(story: appProvider.randomStory, wagons: Constants.months,),
      SeasonTrainScreen(story: appProvider.randomStory),
      FourSeasonScreen(story: appProvider.randomStory),
    ];

    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      appBar: topBar(context, Constants.kTitle),
      body: Center(
        child: appProvider.isfetching
            ? CircularProgressIndicator()
            : LiveGrid.options(
                options: options,
                itemBuilder: buildAnimatedItem,
                itemCount: kExerciceNames.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveWidget.isLargeScreen(context) ? 5 : ResponsiveWidget.isSmallScreen(context) ? 2 : 5,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Les exercices'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Les histoires'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('A propos'),
          )
        ],
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
            color: kExerciceColors[index],
            elevation: 4.0,
            margin: EdgeInsets.all(1.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => exerciceRoutes[index]));
              },
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text(
                        kExerciceNames[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(title: Constants.appName)));
      }
    });
  }

}
