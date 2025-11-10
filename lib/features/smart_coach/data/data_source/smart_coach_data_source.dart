import 'package:fitness/core/result/result.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../domain/entity/message_entity.dart';
// abstract interface class SmartCoachDataSource {
//   Future<Result<Stream<Candidates?>>> streamChatWithSpecialPrompt(
//       List<Content> chatHistory, {
//         String? model,
//         String? userName,
//       });
//   Future<Result<String>>startNewConversation();
//   Future<Result<void>>setConversionTitle(String conversionId,String title);
//   Future<Result<void>>saveMessage(String conversionId,MessageEntity message);
//   Future<Result<List<MessageEntity>>> getMessages(String conversionId);
//   Future<Result<List<Map<String, dynamic>>>> getConversationSummaries();
// }
abstract class SmartCoachRemoteDataSource {
  Stream<Candidates?> getSmartCoachResponseStream(List<Content> chatHistory,
      {String? model});
  Future<Result<List<Map<String, dynamic>>>> fetchConversationSummaries();
  Future<Result<List<MessageEntity>>> fetchMessages(String conversationId);
  Future<Result<void>> deleteConversation(String conversationId);
  Future<Result<String>> startNewConversation();
  Future<Result<void>> saveMessage(String conversationId, MessageEntity message);
  Future<Result<void>> setConversationTitle(String conversationId, String title);
}