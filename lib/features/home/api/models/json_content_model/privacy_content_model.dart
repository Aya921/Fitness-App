import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/api/models/json_content_model/help_content_model.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';


class PrivacyPolicyModel extends Equatable {
  final List<PrivacySectionModel> sections;

  const PrivacyPolicyModel({required this.sections});

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    final contentList = json['privacy_policy'] as List;
    return PrivacyPolicyModel(
      sections: contentList
          .map((e) => PrivacySectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  PrivacyPolicyEntity toEntity() {
    return PrivacyPolicyEntity(
      sections: sections.map((section) => section.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [sections];
}

class PrivacySectionModel extends Equatable {
  final String? section;
  final LocalizedText? title;
  final dynamic content;
  final List<SubSectionModel>? subSections;

  const PrivacySectionModel({
    this.section,
    this.title,
    this.content,
    this.subSections,
  });

  factory PrivacySectionModel.fromJson(Map<String, dynamic> json) {
    dynamic parsedContent;
    
    if (json['content'] is Map) {
      parsedContent = LocalizedText.fromJson(json['content']);
    } else if (json['content'] is List) {
      parsedContent = json['content'];
    }

    List<SubSectionModel>? subSections;
    if (json['sub_sections'] is List) {
      subSections = (json['sub_sections'] as List)
          .map((e) => SubSectionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return PrivacySectionModel(
      section: json['section'] as String?,
      title: json['title'] != null ? LocalizedText.fromJson(json['title']) : null,
      content: parsedContent,
      subSections: subSections,
    );
  }

  PrivacySectionEntity toEntity() {
    dynamic entityContent;
    if (content is LocalizedText) {
      entityContent = (content as LocalizedText).toEntity();
    } else if (content is List) {
      entityContent = content;
    }

    return PrivacySectionEntity(
      section: section,
      title: title?.toEntity(),
      content: entityContent,
      subSections: subSections?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [section, title, content, subSections];
}

class SubSectionModel extends Equatable {
  final String? type;
  final LocalizedText? title;
  final LocalizedText? content;

  const SubSectionModel({
    this.type,
    this.title,
    this.content,
  });

  factory SubSectionModel.fromJson(Map<String, dynamic> json) {
    return SubSectionModel(
      type: json['type'] as String?,
      title: json['title'] != null ? LocalizedText.fromJson(json['title']) : null,
      content: json['content'] != null ? LocalizedText.fromJson(json['content']) : null,
    );
  }

  SubSectionEntity toEntity() {
    return SubSectionEntity(
      type: type,
      title: title?.toEntity(),
      content: content?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [type, title, content];
}