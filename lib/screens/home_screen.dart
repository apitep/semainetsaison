import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:after_layout/after_layout.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:semainetsaison/models/story.dart';
import 'package:semainetsaison/screens/season_screen.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../widgets/responsive_widget.dart';
import '../providers/app_provider.dart';
import 'rightorder_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  static const routeName = '/home';
  final Key key = UniqueKey();
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin<HomeScreen> {
  AppProvider appProvider;
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
  void afterFirstLayout(BuildContext context) {
    AssetsAudioPlayer.newPlayer().open(Audio("assets/sounds/homeintro.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      appBar: topBar(context, Constants.kTitle),
      body: Center(
        child: appProvider.isfetching
            ? CircularProgressIndicator()
            : LiveGrid.options(
                options: options,
                itemBuilder: buildAnimatedItem,
                itemCount: appProvider.stories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveWidget.isLargeScreen(context) ? 5 : ResponsiveWidget.isSmallScreen(context) ? 2 : 5,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
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
            margin: EdgeInsets.all(1.0),
            child: InkWell(
              onTap: () {
                showCredits(appProvider.stories[index]);
              },
              child: Stack(
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(appProvider.stories[index].thumbUrl),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void showCredits(Story story) {
    showDialog(
      context: context,
      builder: (_) => NetworkGiffyDialog(
        image: Image.network(
          story.thumbUrl,
          fit: BoxFit.cover,
        ),
        title: Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 18),
            children: <TextSpan>[
              TextSpan(
                text: '${story.title}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: story.title.length < 22 ? 16 : 13,
                  fontFamily: 'MontserratAlternates',
                  decoration: TextDecoration.none,
                ),
              ),
              story.author.length < 40 ? TextSpan(text: "\n") : TextSpan(text: " "),
              TextSpan(
                text: "de ${story.author}",
                style: TextStyle(
                  fontSize: story.author.length < 30 ? 13 : 11,
                  fontFamily: 'MontserratAlternates',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        description: Text(
          "Termine les exercices pour regarder cet album animé offert par l'école des loisirs.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        entryAnimation: EntryAnimation.TOP,
        buttonOkText: Text("apprendre en s'amusant", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white)),
        onlyOkButton: true,
        onOkButtonPressed: () {
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context) => RightOrderScreen(story: story, rightOrder: Constants.days)));
          Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonScreen()));
        },
      ),
    );
  }
}
