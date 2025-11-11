
import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';


class HelpContentModel extends Equatable {
  final List<HelpSectionModel> sections;

  const HelpContentModel({required this.sections});

  factory HelpContentModel.fromJson(Map<String, dynamic> json) {
    final contentList = json['help_screen_content'] as List;
    return HelpContentModel(
      sections: contentList
          .map((e) => HelpSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  HelpContentEntity toEntity() {
    return HelpContentEntity(
      sections: sections.map((section) => section.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [sections];
}

class HelpSectionModel extends Equatable {
  final String? section;
  final LocalizedText? title;
  final LocalizedText? content;
  final List<ContactMethodModel>? contactMethods;
  final List<FaqItemModel>? faqItems;

  const HelpSectionModel({
    this.section,
    this.title,
    this.content,
    this.contactMethods,
    this.faqItems,
  });

  factory HelpSectionModel.fromJson(Map<String, dynamic> json) {
    final section = json['section'] as String?;
    
    List<ContactMethodModel>? contactMethods;
    List<FaqItemModel>? faqItems;
    
    if (section == 'contact_us' && json['content'] is List) {
      contactMethods = (json['content'] as List)
          .map((e) => ContactMethodModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (section == 'faq' && json['content'] is List) {
      faqItems = (json['content'] as List)
          .map((e) => FaqItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return HelpSectionModel(
      section: section,
      title: json['title'] != null ? LocalizedText.fromJson(json['title']) : null,
      content: json['content'] is Map ? LocalizedText.fromJson(json['content']) : null,
      contactMethods: contactMethods,
      faqItems: faqItems,
    );
  }

  HelpSectionEntity toEntity() {
    return HelpSectionEntity(
      section: section,
      title: title?.toEntity(),
      content: content?.toEntity(),
      contactMethods: contactMethods?.map((e) => e.toEntity()).toList(),
      faqItems: faqItems?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [section, title, content, contactMethods, faqItems];
}

class ContactMethodModel extends Equatable {
  final String? id;
  final LocalizedText? method;
  final LocalizedText? details;
  final String? value;

  const ContactMethodModel({
    this.id,
    this.method,
    this.details,
    this.value,
  });

  factory ContactMethodModel.fromJson(Map<String, dynamic> json) {
    return ContactMethodModel(
      id: json['id'] as String?,
      method: json['method'] != null ? LocalizedText.fromJson(json['method']) : null,
      details: json['details'] != null ? LocalizedText.fromJson(json['details']) : null,
      value: json['value'] as String?,
    );
  }

  ContactMethodEntity toEntity() {
    return ContactMethodEntity(
      id: id,
      method: method?.toEntity(),
      details: details?.toEntity(),
      value: value,
    );
  }

  @override
  List<Object?> get props => [id, method, details, value];
}

class FaqItemModel extends Equatable {
  final String? id;
  final LocalizedText? question;
  final LocalizedText? answer;

  const FaqItemModel({
    this.id,
    this.question,
    this.answer,
  });

  factory FaqItemModel.fromJson(Map<String, dynamic> json) {
    return FaqItemModel(
      id: json['id'] as String?,
      question: json['question'] != null ? LocalizedText.fromJson(json['question']) : null,
      answer: json['answer'] != null ? LocalizedText.fromJson(json['answer']) : null,
    );
  }

  FaqItemEntity toEntity() {
    return FaqItemEntity(
      id: id,
      question: question?.toEntity(),
      answer: answer?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [id, question, answer];
}

class LocalizedText {
  final String? en;
  final String? ar;
  final List<String>? enList;
  final List<String>? arList;

  const LocalizedText({
    this.en,
    this.ar,
    this.enList,
    this.arList,
  });

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    final enVal = json['en'];
    final arVal = json['ar'];
    return LocalizedText(
      en: enVal is String ? enVal : null,
      ar: arVal is String ? arVal : null,
      enList: enVal is List ? enVal.cast<String>() : null,
      arList: arVal is List ? arVal.cast<String>() : null,
    );
  }

  /// Returns either a String or List String depending on what exists.
  dynamic getText(bool isArabic) {
    if (isArabic) return ar ?? arList;
    return en ?? enList;
  }

  LocalizedTextEntity toEntity() => LocalizedTextEntity(
        en: en,
        ar: ar,
        enList: enList,
        arList: arList,
      );
}
