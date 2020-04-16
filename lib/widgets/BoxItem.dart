import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../models/story.dart';

class BoxItem extends StatefulWidget {
  BoxItem(this.item, {Key key}) : super(key: key);

  final Story item;

  @override
  _BoxItemState createState() => _BoxItemState();
}

class _BoxItemState extends State<BoxItem> with SingleTickerProviderStateMixin {
  double pastilleSize = 60;
  double baseWidth;
  double basePadding = 2;

  AnimationControllerX controller = AnimationControllerX();
  Animation<double> animation;

  double rangeMap(double number, double inMin, double inMax, double outMin, double outMax) {
    return (number - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  @override
  void initState() {
    controller.configureVsync(this);
    controller.addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    baseWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
        width: baseWidth,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            this.buildBase(),
            this.buildPastille(),
          ],
        ),
      ),
    );
  }

  Widget buildBase() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: basePadding * 0.1,
      right: pastilleSize * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: this.buildInkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.item.thumbUrl),
              ),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  rangeMap(animation.value, 0.0, 1.0, 0.3, 0.0),
                ),
              ),
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(
                    rangeMap(animation.value, 0.0, 1.0, 0.0, 0.20),
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(
                            basePadding * 3,
                          ).copyWith(
                            right: pastilleSize * 0.5,
                            bottom: 0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.item.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white.withOpacity(
                                    0.88,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'joue et gagne',
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(child: Container()),
                        Container(
                          padding: EdgeInsets.only(
                            right: basePadding * 3,
                            left: basePadding * 3,
                            bottom: basePadding * 2,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 18.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 1.0,
                                  left: basePadding,
                                ),
                                child: Text(
                                  widget.item.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Flexible(child: Container()),
                              Icon(
                                Icons.map,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: basePadding,
                                ),
                                child: Text(
                                  "perfect",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPastille() {
    return Positioned(
      bottom: pastilleSize * 0.8,
      right: 0,
      child: Container(
        width: pastilleSize,
        height: pastilleSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Text(
          "yes",
          style: TextStyle(
            fontSize: pastilleSize * 0.25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildInkWell({
    @required Widget child,
    GestureTapCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    GestureTapDownCallback onTapDown,
    GestureTapCancelCallback onTapCancel,
    ValueChanged<bool> onHighlightChanged,
    ValueChanged<bool> onHover,
    ValueChanged<bool> onFocusChange,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    bool isButton = false,
  }) {
    return InkWell(
      child: child,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      hoverColor: isButton ? null : Colors.transparent,
      focusColor: isButton ? null : Colors.transparent,
      highlightColor: isButton ? null : Colors.transparent,
      splashColor: isButton ? null : Colors.transparent,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      onTapDown: (value) {
        if (onTapDown != null) {
          onTapDown(value);
        }
      },
      onTapCancel: () {
        if (onTapCancel != null) {
          onTapCancel();
        }
      },
      onHover: (value) {
        if (onHover != null) {
          onHover(value);
        }
      },
      onFocusChange: (value) {
        if (onFocusChange != null) {
          onFocusChange(value);
        }
      },
    );
  }
}
