
import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';


class PrivacyPolicyEntity extends Equatable {
  final List<PrivacySectionEntity> sections;

  const PrivacyPolicyEntity({required this.sections});

  @override
  List<Object?> get props => [sections];
}

class PrivacySectionEntity extends Equatable {
  final String? section;
  final LocalizedTextEntity? title;
  final dynamic content;
  final List<SubSectionEntity>? subSections;

  const PrivacySectionEntity({
    this.section,
    this.title,
    this.content,
    this.subSections,
  });

  @override
  List<Object?> get props => [section, title, content, subSections];
}

class SubSectionEntity extends Equatable {
  final String? type;
  final LocalizedTextEntity? title;
  final LocalizedTextEntity? content;

  const SubSectionEntity({
    this.type,
    this.title,
    this.content,
  });

  @override
  List<Object?> get props => [type, title, content];
}