import 'package:fitness/core/enum/levels.dart';

sealed class RegisterIntent {
  const RegisterIntent();
}

final class RegisterInitializationIntent extends RegisterIntent {
  const RegisterInitializationIntent();
}

final class ChangeGenderIntent extends RegisterIntent {
  final String? selectedGender;
  const ChangeGenderIntent({required this.selectedGender});
}
final class SelectHeightIntent extends RegisterIntent {
  final int? height;
  const SelectHeightIntent({required this.height});
}
final class SelectWeightIntent extends RegisterIntent {
  final int? weight;
  const SelectWeightIntent({required this.weight});
}
final class SelectAgeIntent extends RegisterIntent {
  final int? age;
  const SelectAgeIntent({required this.age});
}
final class SelectGoalIntent extends RegisterIntent {
  final String? goal;
  const SelectGoalIntent({required this.goal});
}
final class SelectLevelIntent extends RegisterIntent {
  final ActivityLevel? level;
  const SelectLevelIntent({required this.level});
}
final class RegisterFormIntent extends RegisterIntent {
  const RegisterFormIntent();
}

final class ToggleObscurePasswordIntent extends RegisterIntent {
  const ToggleObscurePasswordIntent();
}

final class ValidateBasicInfoIntent extends RegisterIntent {
  const ValidateBasicInfoIntent();
}
final class IsTypingIntent extends RegisterIntent {
  const IsTypingIntent();
}

