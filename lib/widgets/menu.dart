import 'package:flutter/material.dart';

import '../screens/days_screen.dart';
import '../screens/months_screen.dart';
import '../screens/seasons_screen.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(3.0),
        children: <Widget>[
          makeDashboardItem("Les jours", Icons.book, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DaysScreen()));
          }),
          makeDashboardItem("Les mois", Icons.calendar_view_day, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MonthsScreen()));
          }),
          makeDashboardItem("Les saisons", Icons.satellite, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonsScreen()));
          }),
          makeDashboardItem("Récompenses", Icons.alarm, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonsScreen()));
          }),
        ],
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon, Function tapped) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: InkWell(
            onTap: () => tapped(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                  child: Icon(
                    icon,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Text(title, style: TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}
