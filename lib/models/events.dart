import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus(); // global event bus

class ExerciceSuccess {
  ExerciceSuccess();
}

class CheckResult {
  CheckResult();
}

class MusicBackground {
  bool on;
  MusicBackground(this.on);
}