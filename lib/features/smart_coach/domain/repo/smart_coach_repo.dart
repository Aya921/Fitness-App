
import '../../../../core/result/result.dart';


import '../entity/message_entity.dart';

abstract interface class SmartCoachRepository {
  Stream<String> getSmartCoachReplyStream(List<MessageEntity> chatHistory);
  Future<Result<void>> saveMessage(String conversationId, MessageEntity message);
  Future<Result<List<Map<String, dynamic>>>>  fetchConversationSummaries();
  Future<Result<List<MessageEntity>>> fetchMessages(String conversationId);
  Future<Result<void>> deleteConversation(String conversationId);
  Future<Result<String>> startNewConversation();
  Future<Result<void>> setConversationTitle(String conversationId, String title);
}