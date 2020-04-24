import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus(); // global event bus

class ExerciceSuccess {
  ExerciceSuccess();
}

class CheckResult {
  Key key = UniqueKey();
  CheckResult(this.key);
}

class MusicBackground {
  bool on;
  MusicBackground(this.on);
}