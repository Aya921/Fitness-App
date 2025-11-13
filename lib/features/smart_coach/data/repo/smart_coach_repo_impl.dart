import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/data/data_source/smart_coach_data_source.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/enum/sender.dart';
import '../../../../core/error/gemeni_error.dart';
import '../../domain/entity/message_entity.dart';
import '../../domain/repo/smart_coach_repo.dart';

@Injectable(as: SmartCoachRepository)

class SmartCoachRepositoryImpl implements SmartCoachRepository {

  SmartCoachRepositoryImpl(this.remoteDataSource);
  final SmartCoachRemoteDataSource remoteDataSource;

  List<Content> mapMessagesToGeminiContent(List<MessageEntity> messages) {
    final List<Content> geminiContent = [];
    for (int i = 0; i < messages.length; i++) {
      final msg = messages[i];
      String text = msg.text;

      if (i == 0 && msg.role == Sender.user) {
        text = Constants.fitnessPrefix + text;
      }

      geminiContent.add(Content(
        role: msg.role == Sender.user ? "user" : "model",
        parts: [Part.text(text)],
      ));
    }
    return geminiContent;
  }

  @override
  Stream<String> getSmartCoachReplyStream(List<MessageEntity> chatHistory) {
    try {
      final geminiChatHistory = mapMessagesToGeminiContent(chatHistory);
      final geminiResponseStream = remoteDataSource.
      getSmartCoachResponseStream(geminiChatHistory,
        model: Constants.gemeniModel,  );

      return geminiResponseStream.map((candidate) {
        if (candidate == null || candidate.content == null) {
          return Constants.promptFallback;
        }

        final contentParts = candidate.content!.parts;
        final StringBuffer buffer = StringBuffer();
        for (final part in contentParts!) {
          if (part is TextPart) {
            buffer.write(part.text);
          }
        }
        return buffer.toString().trim();
      }).handleError((error) {
        if (error is GemeniErrorException) {
          throw error;
        }

      });

    } catch (e) {
      throw GemeniErrorException(message: ' $e');
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>>> fetchConversationSummaries() {
    return remoteDataSource.fetchConversationSummaries();
  }

  @override
  Future<Result<List<MessageEntity>>> fetchMessages(String conversationId) {
    return remoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<Result<void>>  deleteConversation(String conversationId) {
    return remoteDataSource.deleteConversation(conversationId);
  }

  @override
  Future<Result<String>> startNewConversation() {
    return remoteDataSource.startNewConversation();
  }

  @override
  Future<Result<void>> saveMessage(String conversationId, MessageEntity message) {
    return remoteDataSource.saveMessage(conversationId, message);
  }

  @override
  Future<Result<void>> setConversationTitle(String conversationId, String title)async {
    return await remoteDataSource.setConversationTitle(conversationId, title);
  }
}