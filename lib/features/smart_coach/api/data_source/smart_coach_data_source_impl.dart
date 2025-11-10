import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/firebase_exception.dart';
import '../../../../core/error/gemeni_error_exception.dart';
import '../../../../core/result/result.dart';
import '../../data/data_source/smart_coach_data_source.dart';
import '../../domain/entity/message_entity.dart';
import '../client/chat_ai_services.dart';
import '../client/firebase_chat_services.dart';



@Injectable(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {

  SmartCoachRemoteDataSourceImpl(this._smartCoachService, this._firebaseChatService);
  final SmartCoachService _smartCoachService;
  final FirebaseChatService _firebaseChatService;

  @override
  Stream<Candidates?> getSmartCoachResponseStream(List<Content> chatHistory
      ,{String? model})
  {
    try {
      final geminiStream = _smartCoachService.streamChat(chatHistory,   model: model,);

      return geminiStream;
    } catch (e) {

      throw GemeniErrorException(
        message: 'smart coach error $e',errorData: e.toString(),

      );
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>>> fetchConversationSummaries() {
    return runSafeResult(()async{
      return _firebaseChatService.fetchConversationSummaries();
    });
  }

  @override
  Future<Result<List<MessageEntity>>> fetchMessages(String conversationId) {
    return runSafeResult(()async{
      return _firebaseChatService.fetchMessages(conversationId);
    });
  }

  @override
  Future<Result<void>> deleteConversation(String conversationId) {
    return runSafeResult(()async{
    return  _firebaseChatService.deleteConversation(conversationId);
    });
  }

  @override
  Future<Result<String>> startNewConversation(){
    return runSafeResult(()async{
      return _firebaseChatService.startNewConversation();
    });
  }

  @override
  Future<Result<void>> saveMessage(String conversationId,
      MessageEntity message) async {
return runSafeResult(()async{
return  await _firebaseChatService.saveMessage(conversationId, message);

});
  }


  @override
  Future<Result<void>> setConversationTitle(String conversationId,
      String title) {
    return runSafeResult(()async{
      return _firebaseChatService.setConversationTitle(conversationId, title);
    });
  }
}