import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/enum/sender.dart';
import 'package:fitness/core/error/firebase_exception.dart';
import 'package:fitness/core/error/gemeni_error_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/api/client/chat_ai_services.dart';
import 'package:fitness/features/smart_coach/api/client/firebase_chat_services.dart';
import 'package:fitness/features/smart_coach/api/data_source/smart_coach_data_source_impl.dart';
import 'package:fitness/features/smart_coach/domain/entity/message_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mockito/mockito.dart';
import 'smart_coach_data_source_impl_test.mocks.dart';

@GenerateMocks([SmartCoachService, FirebaseChatService])
void main() {
  late SmartCoachRemoteDataSourceImpl dataSource;
  late MockSmartCoachService mockAiService;
  late MockFirebaseChatService mockFirebaseService;
  setUpAll(() {
    mockAiService = MockSmartCoachService();
    mockFirebaseService = MockFirebaseChatService();
    dataSource = SmartCoachRemoteDataSourceImpl(
      mockAiService,
      mockFirebaseService,
    );
  });
  group("getSmartCoachResponseStream", () {
    const text = "fitness roadmap";
    const model = "gemini-1.5-flash";
    final List<Content> chatHistory = [
      Content(role: "model", parts: [Part.text(text)]),
    ];
    test("should return stream from service on success", () async {
      final exceptedStream = Stream<Candidates>.fromIterable([
        Candidates(
          content: Content(role: "model", parts: [Part.text(text)]),
          index: 0,
        ),
      ]);

      when(
        mockAiService.streamChat(chatHistory, model: model),
      ).thenAnswer((_) => exceptedStream);
      final result = dataSource.getSmartCoachResponseStream(
        chatHistory,
        model: model,
      );
      expect(result, isA<Stream<Candidates>>());

      expect(result, exceptedStream);
      verify(mockAiService.streamChat(chatHistory, model: model)).called(1);
    });
    test(
      "should throw GemeniErrorException when GeminiException occurs",
      () async {
        final geminiException = GemeniErrorException(
          errorData: "Rate limit exceeded",
          message: 'smart coach error Rate limit exceeded',
          statusCode: 429,
        );
        when(
          mockAiService.streamChat(chatHistory, model: model),
        ).thenAnswer((_) => Stream.error(geminiException));
        final result = dataSource.getSmartCoachResponseStream(
          chatHistory,
          model: model,
        );
        await expectLater(result, emitsError(isA<GemeniErrorException>()));
        verify(mockAiService.streamChat(chatHistory, model: model));
      },
    );
  });
  group("fetch conversion summaries", () {
    final mockData = [
      {'id': '123', 'startedAt': DateTime.now(), 'text': 'Hello there'},
    ];
    test("return SuccessResult when firebase chat success", () async {
      when(
        mockFirebaseService.fetchConversationSummaries(),
      ).thenAnswer((_) async => mockData);
      final result = await dataSource.fetchConversationSummaries();
      expect(result, isA<Result<List<Map<String, dynamic>>>>());
      expect((result as SuccessResult).successResult, mockData);
      verify(mockFirebaseService.fetchConversationSummaries()).called(1);
    });
    test(
      "return FailedResult when firebase chat failed on FirebaseException",
      () async {
        final firebaseException =
            FirestoreExceptionHandler.fromFirebaseException(
              FirebaseException(
                plugin: "permission-denied",
                message:
                    "You do not have permission to access or modify this data.",
              ),
            );
        when(
          mockFirebaseService.fetchConversationSummaries(),
        ).thenThrow(firebaseException);
        final result = await dataSource.fetchConversationSummaries();
        expect(result, isA<Result<List<Map<String, dynamic>>>>());
        expect(
          (result as FailedResult).errorMessage,
          contains("An error occurred while interacting with the database"),
        );
        verify(mockFirebaseService.fetchConversationSummaries()).called(1);
      },
    );
  });
  group("fetch Messages", () {
    const conversationId = '123';
    final messages = [
      const MessageEntity(role: Sender.user, text: "test text"),
      const MessageEntity(role: Sender.model, text: "fitness text"),
    ];
    test(
      "should return Success with list of messages when service succeeds'",
      () async {
        when(
          mockFirebaseService.fetchMessages(conversationId),
        ).thenAnswer((_) async => messages);
        final result = await dataSource.fetchMessages(conversationId);
        expect(result, isA<Result<List<MessageEntity>>>());
        expect((result as SuccessResult).successResult, messages);
        verify(mockFirebaseService.fetchMessages(conversationId)).called(1);
      },
    );
    test(
      "return Failed Result when firebase chat failed on Firebase Exception",
      () async {
        final firebaseException =
            FirestoreExceptionHandler.fromFirebaseException(
              FirebaseException(
                plugin: "not-found",
                message: 'The requested resource was not found.',
              ),
            );

        when(
          mockFirebaseService.fetchMessages(conversationId),
        ).thenThrow(firebaseException);
        final result = await dataSource.fetchMessages(conversationId);
        expect(result, isA<Result<List<MessageEntity>>>());
        expect(
          (result as FailedResult).errorMessage,
          contains("An error occurred while interacting with the database"),
        );
        verify(mockFirebaseService.fetchMessages(conversationId)).called(1);
      },
    );
  });
  group("startNewConversation", () {
    const conversationId = '123';

    test("return SuccessResult when firebase chat success ", () async {
      when(
        mockFirebaseService.startNewConversation(),
      ).thenAnswer((_) async => conversationId);
      final result = await dataSource.startNewConversation();
      expect(result, isA<Result<String>>());
      expect((result as SuccessResult).successResult, conversationId);
      verify(mockFirebaseService.startNewConversation()).called(1);
    });
    test("return FailedResult when firebase chat failed ", () async {
      final firebaseException = FirestoreExceptionHandler.fromFirebaseException(
        FirebaseException(
          plugin: "deadline-exceeded",
          message:
              'The service is currently unavailable. Please try again later.',
        ),
      );
      when(
        mockFirebaseService.startNewConversation(),
      ).thenThrow(firebaseException);
      final result = await dataSource.startNewConversation();
      expect(result, isA<Result<String>>());
      expect(
        (result as FailedResult).errorMessage,
        contains("An error occurred while interacting with the database"),
      );
      verify(mockFirebaseService.startNewConversation()).called(1);
    });
  });
  group("saveMessage", () {
    const conversationId = '123';
    const message = MessageEntity(role: Sender.model, text: "finess test ");
    test("return SuccessResult when firebase chat success ", () async {
      when(
        mockFirebaseService.saveMessage(conversationId, message),
      ).thenAnswer((_) async => {});
      final result = await dataSource.saveMessage(conversationId, message);
      expect(result, isA<Result<void>>());
      expect((result as SuccessResult).successResult, {});
      verify(
        mockFirebaseService.saveMessage(conversationId, message),
      ).called(1);
    });
    test(
      "return FailedResult when firebase chat failed on Firebase Exception",
      () async {
        final firebaseException =
            FirestoreExceptionHandler.fromFirebaseException(
              FirebaseException(
                plugin: 'aborted',
                message: 'The operation was aborted. Please try again.',
              ),
            );
        when(
          mockFirebaseService.saveMessage(conversationId, message),
        ).thenThrow(firebaseException);
        final result = await dataSource.saveMessage(conversationId, message);
        expect(result, isA<Result<void>>());
        expect(
          (result as FailedResult).errorMessage,
          contains("An error occurred while interacting with the database"),
        );
        verify(
          mockFirebaseService.saveMessage(conversationId, message),
        ).called(1);
      },
    );
  });
  group("setConversationTitle", () {
    const conversationId = '123';
    const title = "test-title";
    test("return SuccessResult when firebase chat success ", () async {
      when(
        mockFirebaseService.setConversationTitle(conversationId, title),
      ).thenAnswer((_) async => {});
      final result = await dataSource.setConversationTitle(
        conversationId,
        title,
      );
      expect(result, isA<Result<void>>());
      expect((result as SuccessResult).successResult, {});
      verify(
        mockFirebaseService.setConversationTitle(conversationId, title),
      ).called(1);
    });
    test("return Failed Result when firebase chat fails", () async {
      final firebaseException = FirestoreExceptionHandler.fromFirebaseException(
        FirebaseException(
          plugin: "deadline-exceeded",
          message:
              'The service is currently unavailable. Please try again later.',
        ),
      );
      when(
        mockFirebaseService.setConversationTitle(conversationId, title),
      ).thenThrow(firebaseException);
      final result = await dataSource.setConversationTitle(
        conversationId,
        title,
      );
      expect(result, isA<Result<void>>());
      expect(
        (result as FailedResult).errorMessage,
        contains("An error occurred while interacting with the database"),
      );
      verify(
        mockFirebaseService.setConversationTitle(conversationId, title),
      ).called(1);
    });
  });
  group("delete Conversation", () {
    const conversationId = '123';
    test("return SuccessResult when firebase chat succsed", () async {
      when(
        mockFirebaseService.deleteConversation(conversationId),
      ).thenAnswer((_) async => {});
      final result = await dataSource.deleteConversation(conversationId);
      expect(result, isA<Result<void>>());
      expect((result as SuccessResult).successResult, {});
      verify(mockFirebaseService.deleteConversation(conversationId)).called(1);
    });
    test("return Failed Result when firebase chat fails", () async {
      final firebaseException = FirestoreExceptionHandler.fromFirebaseException(
        FirebaseException(
          plugin: "deadline-exceeded",
          message:
              'The service is currently unavailable. Please try again later.',
        ),
      );
      when(
        mockFirebaseService.deleteConversation(conversationId),
      ).thenThrow(firebaseException);
      final result = await dataSource.deleteConversation(conversationId);
      expect(result, isA<Result<void>>());
      expect(
        (result as FailedResult).errorMessage,
        contains("An error occurred while interacting with the database"),
      );
      verify(mockFirebaseService.deleteConversation(conversationId)).called(1);
    });
  });
}
