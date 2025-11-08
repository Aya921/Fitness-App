import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_weight_screen/edit_weight_body.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_weight_screen/weight_picker_section.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late EditProfileCubit cubit;
  late EditProfileState state;
  late UserEntity? user;

  setUpAll(() async {
  
   TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({}); 
  await configureDependencies(); 
  
  
  cubit = getIt<EditProfileCubit>();
  state = cubit.state;
});

  testWidgets('test EditWeightBody structure ...', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(body: EditWeightBody(cubit: cubit, user: null, state: state)),
      ),
    ),
  );

  await tester.pump(); 
  await tester.pumpAndSettle(const Duration(seconds: 1)); 

  expect(find.byType(Column), findsAtLeast(2));
    expect(find.byType(Row), findsAtLeast(1));
    expect(find.byType(SizedBox), findsAtLeast(4));
    expect(find.byType(CustomPopIcon), findsAtLeast(1));
    expect(find.byType(Logo), findsAtLeast(1));
    expect(find.byType(Padding), findsAtLeast(1));
    expect(find.byType(AnimateText), findsAtLeast(1));
    expect(find.byType(WeightPickerSection), findsAtLeast(1));
   
    

});


}


