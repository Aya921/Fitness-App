// // import 'package:equatable/equatable.dart';
// // import 'package:fitness/core/enum/request_state.dart';
// // import 'package:fitness/features/smart_coach/domain/entity/message_entity.dart';
// // import 'package:flutter_gemini/src/models/candidates/candidates.dart';
// //
// // class SmartCoachStates extends Equatable {
// //   final StateStatus<List<Map<String, dynamic>>> conversationsStatus;
// //   final String? errorConversations;
// //
// //   final StateStatus<String> newConversationStatus;
// //   final String? errorNewConversation;
// //
// //   // حالة إرسال رسالة (stream)
// //   final StateStatus<Stream<Candidates?>> sendMessageStatus;
// //   final String? errorSendMessage;
// //
// //   // حالة جلب تاريخ المحادثة
// //   final StateStatus<List<MessageEntity>> chatHistoryStatus;
// //   final String? errorChatHistory;
// //
// //   // حالة تحديث / حذف رسالة
// //   final StateStatus<void> messageActionStatus;
// //   final String? errorMessageAction;
// //
// //   // بيانات إضافية
// //   final String? currentConversationId;
// //   final List<MessageEntity>? currentMessages;
// //   final Stream<List<MessageEntity>>? messagesStream;
// //
// //   const SmartCoachStates({
// //     this.conversationsStatus = const StateStatus.initial(),
// //     this.errorConversations,
// //     this.newConversationStatus = const StateStatus.initial(),
// //     this.errorNewConversation,
// //     this.sendMessageStatus = const StateStatus.initial(),
// //     this.errorSendMessage,
// //     this.chatHistoryStatus = const StateStatus.initial(),
// //     this.errorChatHistory,
// //     this.messageActionStatus = const StateStatus.initial(),
// //     this.errorMessageAction,
// //     this.currentConversationId,
// //     this.currentMessages,
// //     this.messagesStream,
// //   });
// //
// //   SmartCoachStates copyWith({
// //     StateStatus<List<Map<String, dynamic>>>? conversationsStatus,
// //     String? errorConversations,
// //     StateStatus<String>? newConversationStatus,
// //     String? errorNewConversation,
// //     StateStatus<Stream<Candidates?>>? sendMessageStatus,
// //     String? errorSendMessage,
// //     StateStatus<List<MessageEntity>>? chatHistoryStatus,
// //     String? errorChatHistory,
// //     StateStatus<void>? messageActionStatus,
// //     String? errorMessageAction,
// //     String? currentConversationId,
// //     List<MessageEntity>? currentMessages,
// //     Stream<List<MessageEntity>>? messagesStream,
// //   }) {
// //     return SmartCoachStates(
// //       conversationsStatus: conversationsStatus ?? this.conversationsStatus,
// //       errorConversations: errorConversations ?? this.errorConversations,
// //       newConversationStatus: newConversationStatus ?? this.newConversationStatus,
// //       errorNewConversation: errorNewConversation ?? this.errorNewConversation,
// //       sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
// //       errorSendMessage: errorSendMessage ?? this.errorSendMessage,
// //       chatHistoryStatus: chatHistoryStatus ?? this.chatHistoryStatus,
// //       errorChatHistory: errorChatHistory ?? this.errorChatHistory,
// //       messageActionStatus: messageActionStatus ?? this.messageActionStatus,
// //       errorMessageAction: errorMessageAction ?? this.errorMessageAction,
// //       currentConversationId: currentConversationId ?? this.currentConversationId,
// //       currentMessages: currentMessages ?? this.currentMessages,
// //       messagesStream: messagesStream ?? this.messagesStream,
// //     );
// //   }
// //
// //   @override
// //   List<Object?> get props => [
// //     conversationsStatus,
// //     errorConversations,
// //     newConversationStatus,
// //     errorNewConversation,
// //     sendMessageStatus,
// //     errorSendMessage,
// //     chatHistoryStatus,
// //     errorChatHistory,
// //     messageActionStatus,
// //     errorMessageAction,
// //     currentConversationId,
// //     currentMessages,
// //     messagesStream,
// //   ];
// // }
// import 'package:equatable/equatable.dart';
// import 'package:fitness/core/enum/request_state.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import '../../../../core/error/response_exception.dart';
// import '../../domain/entity/message_entity.dart';
//
// class SmartCoachState extends Equatable {
//   final StateStatus<String> startConversationStatus;
//   final StateStatus<List<MessageEntity>> messagesStatus;
//   final StateStatus<List<MessageEntity>> chatHistoryStatus;
//   final StateStatus<Stream<Candidates?>> geminiStreamStatus;
//   final String? currentConversationId;
//   final String? errorMessage;
//
//   const SmartCoachState({
//     this.startConversationStatus = const StateStatus.initial(),
//     this.messagesStatus = const StateStatus.initial(),
//     this.chatHistoryStatus = const StateStatus.initial(),
//     this.geminiStreamStatus = const StateStatus.initial(),
//     this.currentConversationId,
//     this.errorMessage,
//   });
//
//   SmartCoachState copyWith({
//     StateStatus<String>? startConversationStatus,
//     StateStatus<List<MessageEntity>>? messagesStatus,
//     StateStatus<List<MessageEntity>>? chatHistoryStatus,
//     StateStatus<Stream<Candidates?>>? geminiStreamStatus,
//     String? currentConversationId,
//     String? errorMessage,
//   }) {
//     return SmartCoachState(
//       startConversationStatus:
//       startConversationStatus ?? this.startConversationStatus,
//       messagesStatus: messagesStatus ?? this.messagesStatus,
//       chatHistoryStatus: chatHistoryStatus ?? this.chatHistoryStatus,
//       geminiStreamStatus: geminiStreamStatus ?? this.geminiStreamStatus,
//       currentConversationId:
//       currentConversationId ?? this.currentConversationId,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     startConversationStatus,
//     messagesStatus,
//     chatHistoryStatus,
//     geminiStreamStatus,
//     currentConversationId,
//     errorMessage,
//   ];
// }


import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';

import '../../domain/entity/message_entity.dart';

class SmartCoachChatState extends Equatable {
  const SmartCoachChatState({

    this.stateStatus,
    this.messages,
    this.isLoading = false,
    this.errorMessage,
    this.name,
    this.photo
  });


  final StateStatus? stateStatus;
  final List<MessageEntity>? messages;
  final bool isLoading;
  final String? errorMessage;
final String? photo;
final String? name;

  SmartCoachChatState copyWith({
    String? firstName,

  StateStatus? stateStatus,
    List<MessageEntity>? messages,
    bool? isLoading,
    String? errorMessage,
    String? photo,
     String? name
  }) {
    return SmartCoachChatState(

      stateStatus: stateStatus ?? this.stateStatus,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      photo: photo??this.photo,
      name: name??this.name
    );
  }

  @override
  List<Object?> get props => [ stateStatus, messages, isLoading, errorMessage,photo,name];
}