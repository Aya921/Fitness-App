enum ActivityLevel {
  level1,
  level2,
  level3,
  level4,
  level5,
}
extension ActivityLevelX on ActivityLevel {
  String get key => name; // "level3"

  String get title => switch (this) {
    ActivityLevel.level1 => 'level1',
    ActivityLevel.level2 => 'level1',
    ActivityLevel.level3 => 'level3',
    ActivityLevel.level4 => 'level4',
    ActivityLevel.level5 => 'level5',
  };
}