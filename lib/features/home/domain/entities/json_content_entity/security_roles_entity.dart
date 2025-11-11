import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';


class SecurityRolesEntity extends Equatable {
  final List<SecuritySectionEntity> sections;

  const SecurityRolesEntity({required this.sections});

  @override
  List<Object?> get props => [sections];
}

class SecuritySectionEntity extends Equatable {
  final String? section;
  final LocalizedTextEntity? title;
  final LocalizedTextEntity? content;
  final RoleDefinitionEntity? roleDefinition;

  const SecuritySectionEntity({
    this.section,
    this.title,
    this.content,
    this.roleDefinition,
  });

  @override
  List<Object?> get props => [section, title, content, roleDefinition];
}

class RoleDefinitionEntity extends Equatable {
  final String? roleId;
  final LocalizedTextEntity? name;
  final LocalizedTextEntity? description;
  final List<PermissionEntity>? permissions;

  const RoleDefinitionEntity({
    this.roleId,
    this.name,
    this.description,
    this.permissions,
  });

  @override
  List<Object?> get props => [roleId, name, description, permissions];
}

class PermissionEntity extends Equatable {
  final String? key;
  final LocalizedTextEntity? name;
  final LocalizedTextEntity? description;

  const PermissionEntity({
    this.key,
    this.name,
    this.description,
  });

  @override
  List<Object?> get props => [key, name, description];
}