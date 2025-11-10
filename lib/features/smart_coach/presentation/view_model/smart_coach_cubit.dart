import 'dart:async';

import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/enum/sender.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/delete_conversion_use_case.dart';
import '../../domain/use_case/get_connversation_summaries_use_case.dart';
import '../../domain/use_case/get_message_use_case.dart';
import '../../domain/use_case/get_smart_coach_use_case.dart';
import '../../domain/use_case/save_message_use_case.dart';
import '../../domain/use_case/set_conversion_title.dart';
import '../../domain/use_case/start_new_conversation_use_case.dart';
// @injectable
// class SmartCoachCubit extends Cubit<SmartCoachStates> {
//   SmartCoachCubit(
//       this._deleteMessageUseCase,
//       this._getAllConversationsUseCase,
//       this._getChatHistoryUseCase,
//       this._saveMessageUseCase,
//       this._streamChatWithSpecialPromptUseCase,
//       this._startNewConversationUseCase,
//       this._streamMessagesUseCase,
//       this._updateMessageUseCase,
//       ) : super(const SmartCoachStates());
//
//   final DeleteMessageUseCase _deleteMessageUseCase;
//   final GetAllConversationsUseCase _getAllConversationsUseCase;
//   final GetChatHistoryUseCase _getChatHistoryUseCase;
//   final SaveMessageUseCase _saveMessageUseCase;
//   final StreamChatWithSpecialPromptUseCase _streamChatWithSpecialPromptUseCase;
//   final StartNewConversationUseCase _startNewConversationUseCase;
//   final StreamMessagesUseCase _streamMessagesUseCase;
//   final UpdateMessageUseCase _updateMessageUseCase;
//
//   Future<void> doIntent({required SmartCoachIntent intent}) async {
//     switch (intent) {
//       case InitializeSmartCoachIntent():
//        _loadAllConversations();
//       case LoadAllConversationsIntent():
//         _loadAllConversations();
//       case StartNewConversationIntent():
//         _startNewConversation(intent.meta);
//       case SendMessageIntent():
//         throw UnimplementedError();
//       case LoadChatHistoryIntent():
//         throw UnimplementedError();
//       case UpdateMessageIntent():
//         throw UnimplementedError();
//       case DeleteMessageIntent():
//         throw UnimplementedError();
//     }
//   }
// Future<void>_startNewConversation(Map<String, dynamic>? meta)async{
//     emit(state.copyWith(
//       newConversationStatus: const StateStatus.loading()
//     ));
//     final result=await _startNewConversationUseCase.
//     startNewConversation(meta: meta);
//     switch(result){
//
//       case SuccessResult<String>():
//        emit(state.copyWith(
//           newConversationStatus: StateStatus.success(result.successResult)
//        ));
//       case FailedResult<String>():
//         emit(state.copyWith(
//           errorNewConversation: result.errorMessage,
//             newConversationStatus: StateStatus.failure(
//                ResponseException(message:  result.errorMessage))
//         ));
//     }
// }
//   void _loadAllConversations() async {
//     emit(state.copyWith(conversationsStatus: const StateStatus.loading()));
//     final result = await _getAllConversationsUseCase.call();
//
//     switch (result) {
//       case SuccessResult<List<Map<String, dynamic>>>():
//         emit(state.copyWith(
//           conversationsStatus: StateStatus.success(result.successResult),
//         ));
//       case FailedResult<List<Map<String, dynamic>>>():
//         emit(state.copyWith(
//           errorConversations: result.errorMessage,
//           conversationsStatus: StateStatus.failure(
//             ResponseException(message: result.errorMessage),
//           ),
//         ));
//     }
//   }
//
//
// }

import '../../domain/entity/message_entity.dart';

import 'package:flutter_gemini/flutter_gemini.dart';


@injectable
class SmartCoachCubit extends Cubit<SmartCoachChatState> {
  SmartCoachCubit(
      this.getSmartCoachResponseUseCase,
      this._setConversationTitleUseCase,
      this._startNewConversationUseCase,
      this._saveMessagesUseCase,
      this._getMessagesUseCase,
      this._getConversationSummariesUseCase,
      this._deleteConversationUseCase)
      : super(const SmartCoachChatState(
      stateStatus: StateStatus.initial())) ;
  final DeleteConversationUseCase _deleteConversationUseCase;
  final GetConversationSummariesUseCase _getConversationSummariesUseCase;
  final GetMessagesUseCase _getMessagesUseCase;
  final SaveMessagesUseCase _saveMessagesUseCase;
  final SetConversationTitleUseCase _setConversationTitleUseCase;
  final StartNewConversationUseCase _startNewConversationUseCase;
  final GetSmartCoachResponseUseCase getSmartCoachResponseUseCase;
  String? _currentConversationId;
  StreamSubscription<String>? _chatStreamSubscription;

  @override
  Future<void> close() {
    _chatStreamSubscription?.cancel();
    return super.close();
  }

  late String photo;
  late String name;
  void loadUserData(){
    photo=UserManager().currentUser!.personalInfo!.photo!;
    name=UserManager().currentUser!.personalInfo!.firstName!;
  }

  Future<void> startNewConversation() async {
    emit(state.copyWith(stateStatus: const StateStatus.loading()));

      final result = await _startNewConversationUseCase.call();

     switch(result){
       case SuccessResult<String>():

       emit(state.copyWith(

           stateStatus: StateStatus.success(result.successResult)
       ));
       _currentConversationId=result.successResult;
       case FailedResult<String>():
         emit(state.copyWith(
             stateStatus: StateStatus.failure(
                 ResponseException(message: result.errorMessage))
         ));
     }
  }

  void loadConversation(String conversationId, List<MessageEntity> messages) {
    _currentConversationId = conversationId;
    emit(state.copyWith(messages: messages));
  }

  List<Map<String, dynamic>> _conversationSummaries = [];
  List<Map<String, dynamic>> get conversationSummaries =>
  _conversationSummaries;

  Future<void> fetchConversationSummaries() async {
    emit(state.copyWith(stateStatus: const StateStatus.loading()));
    final result=await _getConversationSummariesUseCase.call();
    switch(result){

      case SuccessResult<List<Map<String, dynamic>>>():
        _conversationSummaries=result.successResult;
       emit(state.copyWith(
           stateStatus: StateStatus.success(result.successResult)
       ));
      case FailedResult<List<Map<String, dynamic>>>():
      emit(state.copyWith(
        errorMessage: result.errorMessage,
          stateStatus: StateStatus.failure(ResponseException(message: result.errorMessage))
      ));
    }

  }

  Future<List<MessageEntity>> fetchMessagesByConversationId(String conversationId) async {
    emit(state.copyWith(stateStatus: const StateStatus.loading()));

    final result=await _getMessagesUseCase.call(conversationId);
    _currentConversationId=conversationId;
     List<MessageEntity> messages=[];
    switch(result){

      case SuccessResult<List<MessageEntity>>():
        messages=result.successResult;
    emit(state.copyWith(
      messages: result.successResult,
        stateStatus: StateStatus.success(result.successResult)
    ));
      case FailedResult<List<MessageEntity>>():
     emit(state.copyWith(
       errorMessage: result.errorMessage,
         stateStatus: StateStatus.failure(ResponseException(message: result.errorMessage))
     ));
    }
    return messages;
  }


  Future<void> deleteConversation(String conversationId) async {

    final result=await _deleteConversationUseCase.
    call(conversationId);
   switch(result){

     case SuccessResult<void>():

    emit(state.copyWith(

      stateStatus: const StateStatus.success({})
    ));

    await fetchConversationSummaries();

     case FailedResult<void>():
       emit(state.copyWith(
         stateStatus: StateStatus.failure(
             ResponseException(message: result.errorMessage)),
         isLoading: false,
         errorMessage: result.errorMessage,
       ));

   }

  }


  void sendMessage(String prompt) async {
    emit(state.copyWith(
      stateStatus: const StateStatus.loading(),
      isLoading: true,
      errorMessage: null,
    ));

    final message = MessageEntity(text: prompt, role: Sender.user);

    if (_currentConversationId == null) {
      final result =
      (await _startNewConversationUseCase.call()) ;
      _currentConversationId=(result as SuccessResult).successResult;
      await _setConversationTitleUseCase.call(
          _currentConversationId!, prompt);
    }

    await _saveMessagesUseCase.call(
        _currentConversationId!, message);


    final messagesWithNewUser = [...?state.messages, message];
    emit(state.copyWith(messages: messagesWithNewUser));

    const aiMessagePlaceholder = MessageEntity(text: '', role: Sender.model);
    final messagesWithPlaceholder = [
      ...messagesWithNewUser,
      aiMessagePlaceholder
    ];
    emit(state.copyWith(messages: messagesWithPlaceholder));

    final StringBuffer buffer = StringBuffer();
    final List<MessageEntity> updatedList = List.from(messagesWithPlaceholder);

    await _chatStreamSubscription?.cancel();

    _chatStreamSubscription =
        getSmartCoachResponseUseCase.call(messagesWithNewUser).listen(
              (chunk) {
            buffer.write(chunk);

            if (updatedList.isNotEmpty && updatedList.last.role == Sender.user) {
              updatedList
                  .add(aiMessagePlaceholder.copyWith(text: buffer.toString()));
            } else if (updatedList.isNotEmpty) {
              updatedList[updatedList.length - 1] =
                  aiMessagePlaceholder.copyWith(text: buffer.toString());
            }

            emit(state.copyWith(messages: updatedList));
          },
          onError: (error) {
            String displayErrorMessage =
                'An unknown error occurred. Please try again.';

            if (error is GeminiException) {
            error="";
              if (error.statusCode == 429) {
                displayErrorMessage =
                    "too many requests";
              } else {
                displayErrorMessage = '  ${error.message}';
              }
            }

            final errorMessagesList =
            List<MessageEntity>.from(state.messages ?? []);
            _updateLastMessageWithError(displayErrorMessage, errorMessagesList);

            emit(state.copyWith(
              stateStatus: StateStatus.failure(ResponseException(message: error)),
              isLoading: false,
              errorMessage: displayErrorMessage,
            ));
          },
          onDone: () async {
            emit(state.copyWith(
              stateStatus: StateStatus.success(updatedList),
              isLoading: false,
              errorMessage: null,
            ));

            if (updatedList.isNotEmpty &&
                updatedList.last.role == Sender.model &&
                updatedList.last.text.isNotEmpty) {
              await _saveMessagesUseCase.call(
                _currentConversationId!,
                updatedList.last,
              );
            }
          },
        );
  }


  void _updateLastMessageWithError(
      String errorMessage, List<MessageEntity>? currentMessages) {
    final updatedMessageList = List<MessageEntity>.from(currentMessages!);
    if (updatedMessageList.isNotEmpty &&
        updatedMessageList.last.role == Sender.model &&
        updatedMessageList.last.text.isEmpty) {
      updatedMessageList[updatedMessageList.length - 1] =
          updatedMessageList.last.copyWith(text: errorMessage);
    } else {
      updatedMessageList
          .add(MessageEntity(text: errorMessage, role: Sender.model));
    }
    emit(state.copyWith(messages: updatedMessageList));
  }
}