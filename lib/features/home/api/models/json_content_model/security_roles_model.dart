import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/api/models/json_content_model/help_content_model.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';


class SecurityRolesModel extends Equatable {
  final List<SecuritySectionModel> sections;

  const SecurityRolesModel({required this.sections});

  factory SecurityRolesModel.fromJson(Map<String, dynamic> json) {
    final contentList = json['security_roles_config'] as List;
    return SecurityRolesModel(
      sections: contentList
          .map((e) => SecuritySectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  SecurityRolesEntity toEntity() {
    return SecurityRolesEntity(
      sections: sections.map((section) => section.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [sections];
}

class SecuritySectionModel extends Equatable {
  final String? section;
  final LocalizedText? title;
  final LocalizedText? content;
  final RoleDefinitionModel? roleDefinition;

  const SecuritySectionModel({
    this.section,
    this.title,
    this.content,
    this.roleDefinition,
  });

  factory SecuritySectionModel.fromJson(Map<String, dynamic> json) {
    RoleDefinitionModel? roleDefinition;
    
    if (json['section'] == 'role_definition') {
      roleDefinition = RoleDefinitionModel.fromJson(json);
    }

    return SecuritySectionModel(
      section: json['section'] as String?,
      title: json['title'] != null ? LocalizedText.fromJson(json['title']) : null,
      content: json['content'] != null ? LocalizedText.fromJson(json['content']) : null,
      roleDefinition: roleDefinition,
    );
  }

  SecuritySectionEntity toEntity() {
    return SecuritySectionEntity(
      section: section,
      title: title?.toEntity(),
      content: content?.toEntity(),
      roleDefinition: roleDefinition?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [section, title, content, roleDefinition];
}

class RoleDefinitionModel extends Equatable {
  final String? roleId;
  final LocalizedText? name;
  final LocalizedText? description;
  final List<PermissionModel>? permissions;

  const RoleDefinitionModel({
    this.roleId,
    this.name,
    this.description,
    this.permissions,
  });

  factory RoleDefinitionModel.fromJson(Map<String, dynamic> json) {
    List<PermissionModel>? permissions;
    if (json['permissions'] is List) {
      permissions = (json['permissions'] as List)
          .map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return RoleDefinitionModel(
      roleId: json['role_id'] as String?,
      name: json['name'] != null ? LocalizedText.fromJson(json['name']) : null,
      description: json['description'] != null ? LocalizedText.fromJson(json['description']) : null,
      permissions: permissions,
    );
  }

  RoleDefinitionEntity toEntity() {
    return RoleDefinitionEntity(
      roleId: roleId,
      name: name?.toEntity(),
      description: description?.toEntity(),
      permissions: permissions?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [roleId, name, description, permissions];
}

class PermissionModel extends Equatable {
  final String? key;
  final LocalizedText? name;
  final LocalizedText? description;

  const PermissionModel({
    this.key,
    this.name,
    this.description,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      key: json['key'] as String?,
      name: json['name'] != null ? LocalizedText.fromJson(json['name']) : null,
      description: json['description'] != null ? LocalizedText.fromJson(json['description']) : null,
    );
  }

  PermissionEntity toEntity() {
    return PermissionEntity(
      key: key,
      name: name?.toEntity(),
      description: description?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [key, name, description];
}