import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:semainetsaison/screens/days_order_screen.dart';

import '../constants.dart';
import '../controllers/app_controller.dart';
import '../widgets/topbar.dart';
import '../screens/home_screen.dart';
import '../screens/fourseason_screen.dart';
import '../screens/train_screen.dart';
import 'months_order_screen.dart';

const kExerciceNames = ["L'ordre des jours", "L'ordre des mois", 'Le train des jours', 'Le train des mois', 'Le train des saisons', 'Les 4 saisons'];
const kExerciceColors = [Colors.amber, Colors.blue, Colors.brown, Colors.green, Colors.pink, Colors.purple];

class ExercicesScreen extends StatefulWidget {
  ExercicesScreen({Key key, this.title}) : super(key: key);
  static const routeName = '/exercices';
  @override
  final Key key = UniqueKey();
  final String title;

  @override
  _ExercicesScreenState createState() => _ExercicesScreenState();
}

class _ExercicesScreenState extends State<ExercicesScreen> {
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
    exerciceRoutes = [
      DaysOrderScreen(story: AppController.to.randomStory),
      MonthsOrderScreen(story: AppController.to.randomStory),
      TrainScreen(
        story: AppController.to.randomStory,
        wagons: Constants.days,
        nbWagons: 3,
        exerciceDescription: 'Complète le train avec les jours de la semaine.',
      ),
      TrainScreen(
          story: AppController.to.randomStory, wagons: Constants.months, nbWagons: 3, exerciceDescription: "Complète le train avec les mois de l'année."),
      TrainScreen(
          story: AppController.to.randomStory,
          wagons: AppController.to.getRandomSeason(),
          nbWagons: 4,
          exerciceDescription: 'Complète le train avec les mois de la saison.'),
      FourSeasonScreen(story: AppController.to.randomStory),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      appBar: topBar(context, Constants.kTitle),
      body: OrientationBuilder(builder: (context, orientation) {
        return Center(
          child: AppController.to.isfetching.value
              ? CircularProgressIndicator()
              : LiveGrid.options(
                  options: options,
                  itemBuilder: buildAnimatedItem,
                  itemCount: kExerciceNames.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: orientation == Orientation.landscape ? 2 : 1,
                    crossAxisCount: orientation == Orientation.landscape ? 3 : 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Les exercices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Les histoires',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'A propos',
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
      if (index == 2) {
        Get.toNamed('/onboarding');
      }
    });
  }
}
