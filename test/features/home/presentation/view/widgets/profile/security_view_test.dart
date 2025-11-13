import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/security_view.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'security_view_test.mocks.dart';

@GenerateMocks([SecurityCubit, AppLanguageConfig])
void main() {
  late MockSecurityCubit mockSecurityCubit;
  late MockAppLanguageConfig mockAppLanguageConfig;
  final getItInstance = GetIt.instance;

  setUp(() {
    mockSecurityCubit = MockSecurityCubit();
    mockAppLanguageConfig = MockAppLanguageConfig();

    when(
      mockSecurityCubit.stream,
    ).thenAnswer((_) => const Stream<SecurityState>.empty());

    when(mockAppLanguageConfig.isEn()).thenReturn(true);
    when(mockAppLanguageConfig.selectedLocal).thenReturn('en');
    when(mockAppLanguageConfig.changeLocal(any)).thenAnswer((_) async {});

    getItInstance.registerFactory<SecurityCubit>(() => mockSecurityCubit);
    getItInstance.registerFactory<AppLanguageConfig>(
          () => mockAppLanguageConfig,
    );
  });

  tearDown(getItInstance.reset);

  Widget prepareWidget() {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<SecurityCubit>(
          create: (context) => mockSecurityCubit,
          child: const SecurityView(),
        ),
      ),
    );
  }

  const fakeSecurityContentEntityComplete = SecurityRolesEntity(
    sections: [
      SecuritySectionEntity(
        section: "page_title",
        content: LocalizedTextEntity(
          en: "User Roles & Permissions",
          ar: "أدوار المستخدم والأذونات",
        ),
      ),
      SecuritySectionEntity(
        section: "page_description",
        content: LocalizedTextEntity(
          en: "Understand different user roles and their permissions",
          ar: "فهم أدوار المستخدمين المختلفة وأذوناتهم",
        ),
      ),
      SecuritySectionEntity(
        section: "role_list_title",
        title: LocalizedTextEntity(
          en: "Available Roles",
          ar: "الأدوار المتاحة",
        ),
      ),
      SecuritySectionEntity(
        section: "role_definition",
        roleDefinition: RoleDefinitionEntity(
          name: LocalizedTextEntity(
            en: "Administrator",
            ar: "المسؤول",
          ),
          description: LocalizedTextEntity(
            en: "Full system access with all permissions",
            ar: "وصول كامل إلى النظام مع جميع الأذونات",
          ),
          permissions: [
            PermissionEntity(
              name: LocalizedTextEntity(
                en: "Manage Users",
                ar: "إدارة المستخدمين",
              ),
              description: LocalizedTextEntity(
                en: "Create, edit, and delete user accounts",
                ar: "إنشاء وتحرير وحذف حسابات المستخدمين",
              ),
            ),
            PermissionEntity(
              name: LocalizedTextEntity(
                en: "System Configuration",
                ar: "تكوين النظام",
              ),
              description: LocalizedTextEntity(
                en: "Configure system settings and preferences",
                ar: "تكوين إعدادات النظام والتفضيلات",
              ),
            ),
          ],
        ),
      ),
      SecuritySectionEntity(
        section: "role_definition",
        roleDefinition: RoleDefinitionEntity(
          name: LocalizedTextEntity(
            en: "Regular User",
            ar: "مستخدم عادي",
          ),
          description: LocalizedTextEntity(
            en: "Standard access with limited permissions",
            ar: "وصول قياسي مع أذونات محدودة",
          ),
          permissions: [
            PermissionEntity(
              name: LocalizedTextEntity(
                en: "View Content",
                ar: "عرض المحتوى",
              ),
              description: LocalizedTextEntity(
                en: "Access and view available content",
                ar: "الوصول إلى المحتوى المتاح وعرضه",
              ),
            ),
          ],
        ),
      ),
    ],
  );

  group('SecurityView Widget Tests', () {
    testWidgets('should verify structure', (WidgetTester tester) async {
      when(
        mockSecurityCubit.state,
      ).thenReturn(
        const SecurityState(securityRolesState: StateStatus.loading()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(HomeBackground), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(
        find.byWidgetPredicate((widget) => widget is BlocConsumer),
        findsOneWidget,
      );
    });

    testWidgets('HomeBackground should have correct properties', (
        WidgetTester tester,
        ) async {
      when(
        mockSecurityCubit.state,
      ).thenReturn(
        const SecurityState(securityRolesState: StateStatus.loading()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      final homeBackground = tester.widget<HomeBackground>(
        find.byType(HomeBackground),
      );
      expect(homeBackground.image, equals(AssetsManager.homeBackground));
      expect(homeBackground.alpha, equals(.12));
    });

    testWidgets('should display loading indicator when state is loading', (
        WidgetTester tester,
        ) async {
      when(
        mockSecurityCubit.state,
      ).thenReturn(
        const SecurityState(securityRolesState: StateStatus.loading()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is CircularProgressIndicator &&
              widget.color == AppColors.orange,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display loading indicator when state is initial', (
        WidgetTester tester,
        ) async {
      when(
        mockSecurityCubit.state,
      ).thenReturn(
        const SecurityState(securityRolesState: StateStatus.initial()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is CircularProgressIndicator &&
              widget.color == AppColors.orange,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display error message when state is failure', (
        WidgetTester tester,
        ) async {
      const errorMessage = 'Failed to load security roles';
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState: StateStatus.failure(
            ResponseException(message: errorMessage),
          ),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Center), findsWidgets);
      expect(find.byType(Column), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Icon &&
              widget.icon == Icons.error_outline &&
              widget.color == Colors.redAccent &&
              widget.size == 48,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.style?.color == Colors.redAccent &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display content when state is success with data', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomPopIcon), findsOneWidget);
      expect(find.text("User Roles & Permissions"), findsOneWidget);
      expect(
        find.text("Understand different user roles and their permissions"),
        findsOneWidget,
      );
      expect(find.text("Available Roles"), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Header text
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == "User Roles & Permissions" &&
              widget.style ==
                  const TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ) &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );

      // Description text
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data ==
                  "Understand different user roles and their permissions" &&
              widget.style ==
                  const TextStyle(fontSize: 16, color: AppColors.gray) &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );

      // Section title
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == "Available Roles" &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should navigate back when CustomPopIcon is tapped', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final customPopIcon = find.byType(CustomPopIcon);
      expect(customPopIcon, findsOneWidget);

      await tester.tap(customPopIcon);
      await tester.pumpAndSettle();

      expect(find.byType(SecurityView), findsNothing);
    });

    testWidgets('should display role definitions correctly', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Administrator'), findsOneWidget);
      expect(find.text('Regular User'), findsOneWidget);
      expect(
        find.text('Full system access with all permissions'),
        findsOneWidget,
      );
      expect(
        find.text('Standard access with limited permissions'),
        findsOneWidget,
      );

      // Role name styling
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == 'Administrator' &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        findsOneWidget,
      );

      // Role description styling
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == 'Full system access with all permissions' &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display permissions correctly', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Permissions:'), findsNWidgets(2));
      expect(find.text('Manage Users'), findsOneWidget);
      expect(find.text('System Configuration'), findsOneWidget);
      expect(find.text('View Content'), findsOneWidget);
      expect(
        find.text('Create, edit, and delete user accounts'),
        findsOneWidget,
      );
      expect(
        find.text('Configure system settings and preferences'),
        findsOneWidget,
      );
      expect(
        find.text('Access and view available content'),
        findsOneWidget,
      );

      // Check for permission icons
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Icon &&
              widget.icon == Icons.check_circle &&
              widget.color == AppColors.orange &&
              widget.size == 16,
        ),
        findsNWidgets(3),
      );

      // Permission name styling
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == 'Manage Users' &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
        ),
        findsOneWidget,
      );

      // Permission description styling
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == 'Create, edit, and delete user accounts' &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.gray,
                    fontSize: 13,
                    height: 1.4,
                  ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display role cards with correct styling', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // containers with role card styling
      final roleCards = tester.widgetList<Container>(
        find.byWidgetPredicate(
              (widget) =>
          widget is Container &&
              widget.margin == const EdgeInsets.only(bottom: 16) &&
              widget.padding == const EdgeInsets.all(16),
        ),
      );

      expect(roleCards.length, greaterThanOrEqualTo(2));
    });

    testWidgets('should have correct text styles for section titles', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final availableRolesTitle = tester.widget<Text>(
        find.text('Available Roles'),
      );
      expect(availableRolesTitle.style?.color, AppColors.orange);
      expect(availableRolesTitle.style?.fontSize, 20);
      expect(availableRolesTitle.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should display description only when not empty', (
        WidgetTester tester,
        ) async {
      const entityWithoutDescription = SecurityRolesEntity(
        sections: [
          SecuritySectionEntity(
            section: "page_title",
            content: LocalizedTextEntity(
              en: "User Roles & Permissions",
              ar: "أدوار المستخدم والأذونات",
            ),
          ),
          SecuritySectionEntity(
            section: "page_description",
            content: LocalizedTextEntity(en: "", ar: ""),
          ),
        ],
      );

      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState: StateStatus.success(entityWithoutDescription),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('User Roles & Permissions'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.style?.color == AppColors.gray &&
              widget.style?.fontSize == 16 &&
              widget.textAlign == TextAlign.center,
        ),
        findsNothing,
      );
    });

    testWidgets('should skip page_title and page_description in ListView', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Verify that page_title and page_description sections return SizedBox.shrink
      expect(find.text('Available Roles'), findsOneWidget);
      expect(find.text('Administrator'), findsOneWidget);
      expect(find.text('Regular User'), findsOneWidget);
    });

    testWidgets('should handle role without permissions', (
        WidgetTester tester,
        ) async {
      const entityWithRoleWithoutPermissions = SecurityRolesEntity(
        sections: [
          SecuritySectionEntity(
            section: "page_title",
            content: LocalizedTextEntity(
              en: "User Roles & Permissions",
              ar: "أدوار المستخدم والأذونات",
            ),
          ),
          SecuritySectionEntity(
            section: "role_definition",
            roleDefinition: RoleDefinitionEntity(
              name: LocalizedTextEntity(
                en: "Guest",
                ar: "ضيف",
              ),
              description: LocalizedTextEntity(
                en: "Limited access for guests",
                ar: "وصول محدود للضيوف",
              ),
              permissions: [],
            ),
          ),
        ],
      );

      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(entityWithRoleWithoutPermissions),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Guest'), findsOneWidget);
      expect(find.text('Limited access for guests'), findsOneWidget);
      // Permissions section should not appear
      expect(find.text('Permissions:'), findsNothing);
    });

    testWidgets('should display multiple roles correctly', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Verify both roles are displayed
      expect(find.text('Administrator'), findsOneWidget);
      expect(find.text('Regular User'), findsOneWidget);

      // Verify role cards structure
      final roleCards = tester.widgetList<Container>(
        find.byWidgetPredicate(
              (widget) =>
          widget is Container &&
              widget.margin == const EdgeInsets.only(bottom: 16),
        ),
      );
      expect(roleCards.length, greaterThanOrEqualTo(2));
    });

    testWidgets('should display permissions with check icons', (
        WidgetTester tester,
        ) async {
      when(mockSecurityCubit.state).thenReturn(
        const SecurityState(
          securityRolesState:
          StateStatus.success(fakeSecurityContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Count check_circle icons (3 permissions total in the test data)
      final checkIcons = tester.widgetList<Icon>(
        find.byWidgetPredicate(
              (widget) =>
          widget is Icon &&
              widget.icon == Icons.check_circle &&
              widget.color == AppColors.orange,
        ),
      );
      expect(checkIcons.length, equals(3));
    });
  });
}