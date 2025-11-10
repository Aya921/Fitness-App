import 'package:equatable/equatable.dart';

class JsonContentModel extends Equatable {
  final List<JsonSectionModel> sections;

  const JsonContentModel({required this.sections});

  factory JsonContentModel.fromJson(Map<String, dynamic> json) {
    // Find the first key that contains a list (flexible approach)
    final contentList = json.values.firstWhere(
      (value) => value is List,
      orElse: () => [],
    ) as List;

    return JsonContentModel(
      sections: contentList
          .map((e) => JsonSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [sections];
}

class JsonSectionModel extends Equatable {
  final String? section;
  final dynamic title;
  final dynamic content;
  final Map<String, dynamic>? style;
  final List<dynamic>? subSections;

  const JsonSectionModel({
    this.section,
    this.title,
    this.content,
    this.style,
    this.subSections,
  });

  factory JsonSectionModel.fromJson(Map<String, dynamic> json) {
    return JsonSectionModel(
      section: json['section'] as String?,
      title: json['title'],
      content: json['content'],
      style: json['style'] as Map<String, dynamic>?,
      subSections: json['sub_sections'] as List?,
    );
  }

  String getLocalizedText(dynamic field, String languageCode) {
    if (field == null) return '';
    if (field is String) return field;
    if (field is Map) {
      return field[languageCode == 'ar' ? 'ar' : 'en']?.toString() ?? '';
    }
    return '';
  }

  @override
  List<Object?> get props => [section, title, content, style, subSections];
}