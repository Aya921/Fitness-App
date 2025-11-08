import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/firebase_exception.dart';
import '../../../../core/error/gemeni_error_exception.dart';
import '../../../../core/result/result.dart';
import '../../data/data_source/smart_coach_data_source.dart';
import '../../domain/entity/message_entity.dart';
import '../client/chat_ai_services.dart';
import '../client/firebase_chat_services.dart';


// @Injectable(as: SmartCoachDataSource)
// class SmartCoachDataSourceImpl implements SmartCoachDataSource {
//   final SmartCoachApiServices _smartCoachService;
//   final FirebaseChatServices _firebaseChatService;
//
//   SmartCoachDataSourceImpl(this._smartCoachService, this._firebaseChatService);
//
//   // 🟢 SmartCoach stream chat
//   @override
//   Future<Result<Stream<Candidates?>>> streamChatWithSpecialPrompt(
//       List<Content> chatHistory, {
//         String? model,
//         String? userName,
//       }) async {
//     try {
//       final stream = _smartCoachService.streamChatWithSpecialPrompt(
//         chatHistory,
//         model: model,
//         userName: userName,
//       );
//       return SuccessResult(stream);
//     } on GeminiException catch (e) {
//       return FailedResult(
//         GemeniErrorException(
//           message: 'Gemini API error: ${e.message}',
//           statusCode: e.statusCode,
//           errorData: e.toString(),
//         ).toString(),
//       );
//     } catch (e) {
//       return FailedResult('Failed to get SmartCoach response: $e');
//     }
//   }
//
//   @override
//   Future<Result<List<Map<String, dynamic>>>> getConversationSummaries() {
//    return runSafeResult(()async{
//      return await _firebaseChatService.getConversationSummaries();
//    });
//   }
//
//   @override
//   Future<Result<List<MessageEntity>>> getMessages(String conversionId) {
//     return runSafeResult(()async{
//       return await _firebaseChatService.getMessages(conversionId);
//     });
//   }
//
//   @override
//   Future<Result<void>> saveMessage(String conversionId, MessageEntity message) {
//     return runSafeResult(()async{
//       return await _firebaseChatService.saveMessage(conversionId, message);
//     });
//   }
//
//   @override
//   Future<Result<void>> setConversionTitle(String conversionId, String title) {
//     return runSafeResult(()async{
//       return await _firebaseChatService.setConversionTitle(conversionId, title);
//     });
//   }
//
//   @override
//   Future<Result<String>> startNewConversation() {
//     return runSafeResult(()async{
//       return await _firebaseChatService.startNewConversation();
//     });
//   }
//
//
// }
@Injectable(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {

  SmartCoachRemoteDataSourceImpl(this._smartCoachService, this._firebaseChatService);
  final SmartCoachService _smartCoachService;
  final FirebaseChatService _firebaseChatService;

  @override
  Stream<Candidates?> getSmartCoachResponseStream(List<Content> chatHistory,{String? model}) {
    try {
      final geminiStream = _smartCoachService.streamChat(chatHistory,   model: model,);

      return geminiStream.handleError((error) {
        if (error is GeminiException) {
          throw GemeniErrorException(
            message: error.message.toString(),
            statusCode: error.statusCode,
            errorData: error.toString(),
          );
        }
        throw error;
      });
    } catch (e) {
      throw GemeniErrorException(message: 'smart coach error $e');
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
  Future<void> deleteConversation(String conversationId) {
    return _firebaseChatService.deleteConversation(conversationId);
  }

  @override
  Future<Result<String>> startNewConversation(){
    return runSafeResult(()async{
      return _firebaseChatService.startNewConversation();
    });
  }

  @override
  Future<Result<void>> saveMessage(String conversationId, MessageEntity message) async {
return runSafeResult(()async{
return  await _firebaseChatService.saveMessage(conversationId, message);

});
  }


  @override
  Future<Result<void>> setConversationTitle(String conversationId, String title) {
    return runSafeResult(()async{
      return _firebaseChatService.setConversationTitle(conversationId, title);
    });
  }
}