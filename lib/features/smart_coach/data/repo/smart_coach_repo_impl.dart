import 'package:fitness/core/error/gemeni_error_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/data/data_source/smart_coach_data_source.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/enum/sender.dart';
import '../../domain/entity/message_entity.dart';
import '../../domain/repo/smart_coach_repo.dart';
//
// @Injectable(as: SmartCoachRepository)
// class SmartCoachRepositoryImpl implements SmartCoachRepository {
//   final SmartCoachDataSource _dataSource;
//
//   SmartCoachRepositoryImpl(this._dataSource);
//
//   /// 🔹 يحول رسائل المستخدم والمساعد إلى صيغة Gemini
//   List<Content> _mapMessagesToGeminiContent(List<MessageEntity> messages) {
//     final List<Content> geminiContent = [];
//
//     for (int i = 0; i < messages.length; i++) {
//       final msg = messages[i];
//       String text = msg.text;
//
//       // أول رسالة من المستخدم نضيف فيها الـ prompt prefix
//       if (i == 0 && msg.role == Sender.user) {
//         text = Constants.fitnessPrefix + text;
//       }
//
//       geminiContent.add(
//         Content(
//           role: msg.role == Sender.user ? "user" : "model",
//           parts: [Part.text(text)],
//         ),
//       );
//     }
//
//     return geminiContent;
//   }
//
//   /// 🔹 استرجاع ملخصات المحادثات
//   @override
//   Future<Result<List<Map<String, dynamic>>>> getConversationSummaries() async {
//     return await _dataSource.getConversationSummaries();
//   }
//
//   /// 🔹 استرجاع الرسائل
//   @override
//   Future<Result<List<MessageEntity>>> getMessages(String conversationId) async {
//     return await _dataSource.getMessages(conversationId);
//   }
//
//   /// 🔹 حفظ رسالة في قاعدة البيانات
//   @override
//   Future<Result<void>> saveMessage(
//       String conversationId,
//       MessageEntity message,
//       ) async {
//     return await _dataSource.saveMessage(conversationId, message);
//   }
//
//   /// 🔹 تحديث عنوان المحادثة
//   @override
//   Future<Result<void>> setConversionTitle(
//       String conversationId,
//       String title,
//       ) async {
//     return await _dataSource.setConversionTitle(conversationId, title);
//   }
//
//   /// 🔹 بدء محادثة جديدة
//   @override
//   Future<Result<String>> startNewConversation() async {
//     return await _dataSource.startNewConversation();
//   }
//
//
//   @override
//   Stream<String> streamChatWithSpecialPrompt({
//     required List<MessageEntity> chatHistory,
//     String? model,
//     String? userName,
//   }) async {
//     try {
//       final geminiChatHistory = _mapMessagesToGeminiContent(chatHistory);
//
//       final geminiResponseStream = _dataSource.streamChatWithSpecialPrompt(
//         geminiChatHistory,
//         model: model ?? Constants.gemeniModel,
//         userName: userName,
//       );
//
//       // نحول Stream<Candidates?> إلى Stream<String>
//       final messageStream = geminiResponseStream.map((candidate) {
//         if (candidate == null ||
//             candidate.content == null ||
//             candidate.content!.parts == null) {
//           return Constants.promptFallback;
//         }
//
//         final contentParts = candidate.content!.parts!;
//         final buffer = StringBuffer();
//
//         for (var part in contentParts) {
//           if (part is TextPart && part.text != null) {
//             buffer.write(part.text);
//           }
//         }
//
//         final result = buffer.toString().trim();
//         return result.isEmpty ? Constants.promptFallback : result;
//       }).handleError((error) {
//         throw GeminiException('SmartCoach stream error: $error');
//       });
//
//       // ✅ نرجع النتيجة داخل SuccessResult
//       return SuccessResult(messageStream);
//     } on GeminiException catch (e) {
//       return FailedResult(e.message.toString());
//     } catch (e) {
//       return FailedResult(
//         'SmartCoach encountered an unexpected issue. Please try again.',
//       );
//     }
//   }
//
// }
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