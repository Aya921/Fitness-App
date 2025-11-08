import 'package:fitness/core/enum/levels.dart';

ActivityLevel? activityLevelFromString(String? level) {
  return ActivityLevel.values.firstWhere(
        (e) => e.name == level,
    orElse: () => ActivityLevel.level1,
  );
}