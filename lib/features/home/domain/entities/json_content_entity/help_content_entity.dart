import 'package:equatable/equatable.dart';

class HelpContentEntity extends Equatable {
  final List<HelpSectionEntity> sections;

  const HelpContentEntity({required this.sections});

  @override
  List<Object?> get props => [sections];
}

class HelpSectionEntity extends Equatable {
  final String? section;
  final LocalizedTextEntity? title;
  final LocalizedTextEntity? content;
  final List<ContactMethodEntity>? contactMethods;
  final List<FaqItemEntity>? faqItems;

  const HelpSectionEntity({
    this.section,
    this.title,
    this.content,
    this.contactMethods,
    this.faqItems,
  });

  @override
  List<Object?> get props => [section, title, content, contactMethods, faqItems];
}

class ContactMethodEntity extends Equatable {
  final String? id;
  final LocalizedTextEntity? method;
  final LocalizedTextEntity? details;
  final String? value;

  const ContactMethodEntity({
    this.id,
    this.method,
    this.details,
    this.value,
  });

  @override
  List<Object?> get props => [id, method, details, value];
}

class FaqItemEntity extends Equatable {
  final String? id;
  final LocalizedTextEntity? question;
  final LocalizedTextEntity? answer;

  const FaqItemEntity({
    this.id,
    this.question,
    this.answer,
  });

  @override
  List<Object?> get props => [id, question, answer];
}

class LocalizedTextEntity {
  final String? en;
  final String? ar;
  final List<String>? enList;
  final List<String>? arList;

  const LocalizedTextEntity({
    this.en,
    this.ar,
    this.enList,
    this.arList,
  });

  /// Keep the same dynamic return so your widget logic continues to work.
  dynamic getText(bool isArabic) {
    if (isArabic) return ar ?? arList;
    return en ?? enList;
  }
}
