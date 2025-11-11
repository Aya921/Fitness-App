import 'package:fitness/features/home/api/models/json_content_model/help_content_model.dart';
import 'package:fitness/features/home/api/models/json_content_model/security_roles_model.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SecurityRolesModel', () {
    test('fromJson should parse valid JSON correctly', () {
      // Arrange
      final json = {
        'security_roles_config': [
          {
            'section': 'page_title',
            'content': {
              'en': 'User Roles & Permissions',
              'ar': 'أدوار وصلاحيات المستخدمين',
            },
          },
          {
            'section': 'page_description',
            'content': {
              'en': 'Manage user access',
              'ar': 'إدارة وصول المستخدمين',
            },
          },
          {
            'section': 'role_definition',
            'role_id': 'super_admin',
            'name': {
              'en': 'Super Admin',
              'ar': 'المدير العام',
            },
            'description': {
              'en': 'Full system access',
              'ar': 'وصول كامل للنظام',
            },
            'permissions': [
              {
                'key': 'system.config.write',
                'name': {
                  'en': 'Modify System Config',
                  'ar': 'تعديل إعدادات النظام',
                },
                'description': {
                  'en': 'Can change core settings',
                  'ar': 'يمكنه تغيير الإعدادات الأساسية',
                },
              },
              {
                'key': 'user.all.full',
                'name': {
                  'en': 'Full User Management',
                  'ar': 'إدارة كاملة للمستخدمين',
                },
                'description': {
                  'en': 'Can manage all users',
                  'ar': 'يمكنه إدارة جميع المستخدمين',
                },
              },
            ],
          },
        ],
      };

      // Act
      final model = SecurityRolesModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(3));
      
      expect(model.sections[0].section, equals('page_title'));
      expect(model.sections[0].content?.en, equals('User Roles & Permissions'));
      
      expect(model.sections[1].section, equals('page_description'));
      expect(model.sections[1].content?.ar, equals('إدارة وصول المستخدمين'));
      
      expect(model.sections[2].section, equals('role_definition'));
      expect(model.sections[2].roleDefinition, isNotNull);
      expect(model.sections[2].roleDefinition?.roleId, equals('super_admin'));
      expect(model.sections[2].roleDefinition?.name?.en, equals('Super Admin'));
      expect(model.sections[2].roleDefinition?.permissions, hasLength(2));
      expect(model.sections[2].roleDefinition?.permissions?[0].key,
          equals('system.config.write'));
    });

    test('toEntity should convert model to entity correctly', () {
      // Arrange
      const model = SecurityRolesModel(
        sections: [
          SecuritySectionModel(
            section: 'page_title',
            content: LocalizedText(
              en: 'Roles',
              ar: 'الأدوار',
            ),
          ),
          SecuritySectionModel(
            section: 'role_definition',
            roleDefinition: RoleDefinitionModel(
              roleId: 'admin',
              name: LocalizedText(en: 'Admin', ar: 'مدير'),
              description: LocalizedText(en: 'Admin role', ar: 'دور المدير'),
              permissions: [
                PermissionModel(
                  key: 'user.edit',
                  name: LocalizedText(en: 'Edit Users', ar: 'تعديل المستخدمين'),
                  description: LocalizedText(
                      en: 'Can edit user profiles', ar: 'يمكنه تعديل المستخدمين'),
                ),
              ],
            ),
          ),
        ],
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<SecurityRolesEntity>());
      expect(entity.sections, hasLength(2));
      expect(entity.sections[0].section, equals('page_title'));
      expect(entity.sections[0].content?.en, equals('Roles'));
      
      expect(entity.sections[1].roleDefinition, isNotNull);
      expect(entity.sections[1].roleDefinition?.roleId, equals('admin'));
      expect(entity.sections[1].roleDefinition?.permissions, hasLength(1));
      expect(entity.sections[1].roleDefinition?.permissions?[0].key,
          equals('user.edit'));
    });

    test('fromJson should handle null values correctly', () {
      // Arrange
      final json = {
        'security_roles_config': [
          {
            'section': 'page_title',
          },
        ],
      };

      // Act
      final model = SecurityRolesModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(1));
      expect(model.sections[0].section, equals('page_title'));
      expect(model.sections[0].title, isNull);
      expect(model.sections[0].content, isNull);
      expect(model.sections[0].roleDefinition, isNull);
    });

    test('fromJson should not create roleDefinition for non-role_definition sections',
        () {
      // Arrange
      final json = {
        'security_roles_config': [
          {
            'section': 'page_description',
            'role_id': 'some_id',
            'name': {
              'en': 'Name',
              'ar': 'اسم',
            },
          },
        ],
      };

      // Act
      final model = SecurityRolesModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(1));
      expect(model.sections[0].section, equals('page_description'));
      expect(model.sections[0].roleDefinition, isNull);
    });

    test('toEntity should handle empty permissions list', () {
      // Arrange
      const model = SecurityRolesModel(
        sections: [
          SecuritySectionModel(
            section: 'role_definition',
            roleDefinition: RoleDefinitionModel(
              roleId: 'viewer',
              name: LocalizedText(en: 'Viewer', ar: 'مشاهد'),
              description: LocalizedText(en: 'View only', ar: 'عرض فقط'),
              permissions: [],
            ),
          ),
        ],
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.sections[0].roleDefinition?.permissions, isEmpty);
    });
  });

  group('PermissionModel', () {
    test('fromJson should parse permission correctly', () {
      // Arrange
      final json = {
        'key': 'content.edit',
        'name': {
          'en': 'Edit Content',
          'ar': 'تعديل المحتوى',
        },
        'description': {
          'en': 'Can edit all content',
          'ar': 'يمكنه تعديل كل المحتوى',
        },
      };

      // Act
      final permission = PermissionModel.fromJson(json);

      // Assert
      expect(permission.key, equals('content.edit'));
      expect(permission.name?.en, equals('Edit Content'));
      expect(permission.description?.ar, equals('يمكنه تعديل كل المحتوى'));
    });

    test('toEntity should convert permission to entity', () {
      // Arrange
      const permission = PermissionModel(
        key: 'user.delete',
        name: LocalizedText(en: 'Delete Users', ar: 'حذف المستخدمين'),
        description: LocalizedText(en: 'Can delete', ar: 'يمكنه الحذف'),
      );

      // Act
      final entity = permission.toEntity();

      // Assert
      expect(entity, isA<PermissionEntity>());
      expect(entity.key, equals('user.delete'));
      expect(entity.name?.en, equals('Delete Users'));
    });
  });
}