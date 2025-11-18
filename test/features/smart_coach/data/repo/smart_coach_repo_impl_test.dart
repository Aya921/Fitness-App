import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/enum/sender.dart';
import 'package:fitness/core/error/gemeni_error.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/data/data_source/smart_coach_data_source.dart';
import 'package:fitness/features/smart_coach/data/repo/smart_coach_repo_impl.dart';
import 'package:fitness/features/smart_coach/domain/entity/message_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mockito/mockito.dart';

import 'smart_coach_repo_impl_test.mocks.dart';

@GenerateMocks([SmartCoachRemoteDataSource])
void main() {
  late MockSmartCoachRemoteDataSource mockSmartCoachRemoteDataSource;
  late SmartCoachRepositoryImpl smartCoachRepositoryImpl;
  setUp(() {
    mockSmartCoachRemoteDataSource = MockSmartCoachRemoteDataSource();
    smartCoachRepositoryImpl = SmartCoachRepositoryImpl(
      mockSmartCoachRemoteDataSource,
    );
    provideDummy<Result<List<Map<String, dynamic>>>>(
      FailedResult("dummy error fetchConversationSummaries "),
    );
    provideDummy<Result<List<MessageEntity>>>(
      FailedResult("dummy error fetch message "),
    );
    provideDummy<Result<void>>(FailedResult("error mssage"));
    //
    provideDummy<Result<String>>(FailedResult("error mssage"));
  });
  group("_mapMessagesToGeminiContent", () {
    test(
      'adds fitness prefix ONLY to the very first message when it is from user',
      () {
        final messages = [
          const MessageEntity(text: 'First user', role: Sender.user),
          const MessageEntity(text: 'Second user', role: Sender.user),
          const MessageEntity(text: 'Model reply', role: Sender.model),
          const MessageEntity(text: 'Third user', role: Sender.user),
        ];

        final result = smartCoachRepositoryImpl.mapMessagesToGeminiContent(
          messages,
        );

        expect(result[0].role, 'user');
        expect(result[1].role, 'user');
      },
    );
  });
  group("fetchConversationSummaries", () {
    test("return SuccessResult when data source success", () async {
      final mockData = [
        {'id': '123', 'startedAt': DateTime.now(), 'text': 'Hello there'},
      ];
      when(
        mockSmartCoachRemoteDataSource.fetchConversationSummaries(),
      ).thenAnswer((_) async => SuccessResult(mockData));
      final result = await smartCoachRepositoryImpl
          .fetchConversationSummaries();
      expect(result, isA<Result<List<Map<String, dynamic>>>>());
      expect((result as SuccessResult).successResult, mockData);
      verify(
        mockSmartCoachRemoteDataSource.fetchConversationSummaries(),
      ).called(1);
    });
    test("return SuccessResult when data source failed", () async {
      const error = "failed to load chats";
      when(
        mockSmartCoachRemoteDataSource.fetchConversationSummaries(),
      ).thenAnswer((_) async => FailedResult(error));
      final result = await smartCoachRepositoryImpl
          .fetchConversationSummaries();
      expect(result, isA<Result<List<Map<String, dynamic>>>>());
      expect((result as FailedResult).errorMessage, error);
      verify(
        mockSmartCoachRemoteDataSource.fetchConversationSummaries(),
      ).called(1);
    });
  });
  group("fetchMessages", () {
    const conversationId = '123';

    test("return SuccessResult when data source success", () async {
      final messages = [
        const MessageEntity(role: Sender.user, text: "test text"),
        const MessageEntity(role: Sender.model, text: "fitness text"),
      ];
      when(
        mockSmartCoachRemoteDataSource.fetchMessages(conversationId),
      ).thenAnswer((_) async => SuccessResult(messages));
      final result = await smartCoachRepositoryImpl.fetchMessages(
        conversationId,
      );
      expect(result, isA<Result<List<MessageEntity>>>());
      expect((result as SuccessResult).successResult, messages);
      verify(
        mockSmartCoachRemoteDataSource.fetchMessages(conversationId),
      ).called(1);
    });
    test("return SuccessResult when data source failed", () async {
      const error = "failed to fetch message";
      when(
        mockSmartCoachRemoteDataSource.fetchMessages(conversationId),
      ).thenAnswer((_) async => FailedResult(error));
      final result = await smartCoachRepositoryImpl.fetchMessages(
        conversationId,
      );
      expect(result, isA<Result<List<MessageEntity>>>());
      expect((result as FailedResult).errorMessage, error);
      verify(
        mockSmartCoachRemoteDataSource.fetchMessages(conversationId),
      ).called(1);
    });
  });
  group("delete Message", () {
    const conversationId = '123';

    test("return SuccessResult when data source success", () async {
      when(
        mockSmartCoachRemoteDataSource.deleteConversation(conversationId),
      ).thenAnswer((_) async => SuccessResult(null));
      final result = await smartCoachRepositoryImpl.deleteConversation(
        conversationId,
      );
      expect(result, isA<Result<void>>());
      expect((result as SuccessResult).successResult, null);
      verify(
        mockSmartCoachRemoteDataSource.deleteConversation(conversationId),
      ).called(1);
    });
    test("return FailedResult when data source failed", () async {
      const error = "error in deleting message";
      when(
        mockSmartCoachRemoteDataSource.deleteConversation(conversationId),
      ).thenAnswer((_) async => FailedResult(error));
      final result = await smartCoachRepositoryImpl.deleteConversation(
        conversationId,
      );
      expect(result, isA<Result<void>>());
      expect((result as FailedResult).errorMessage, error);
      verify(
        mockSmartCoachRemoteDataSource.deleteConversation(conversationId),
      ).called(1);
    });
  });
  group("startNewConversation", () {
    const convId = "test";
    test("return SuccessResult when data source success", () async {
      when(
        mockSmartCoachRemoteDataSource.startNewConversation(),
      ).thenAnswer((_) async => SuccessResult(convId));
      final result = await smartCoachRepositoryImpl.startNewConversation();
      expect(result, isA<Result<String>>());
      expect((result as SuccessResult).successResult, convId);
      verify(mockSmartCoachRemoteDataSource.startNewConversation()).called(1);
    });
    test("return FailedResult when data source failed", () async {
      const error = "error to set conversation title ";
      when(
        mockSmartCoachRemoteDataSource.startNewConversation(),
      ).thenAnswer((_) async => FailedResult(error));
      final result = await smartCoachRepositoryImpl.startNewConversation();
      expect(result, isA<Result<String>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockSmartCoachRemoteDataSource.startNewConversation()).called(1);
    });
  });
  group("saveMessage", () {
    const conversationId = '123';
    const message = MessageEntity(role: Sender.model, text: "fitness test ");
    test("return SuccessResult when data source success", () async {
      when(
        mockSmartCoachRemoteDataSource.saveMessage(conversationId, message),
      ).thenAnswer((_) async => SuccessResult(null));
      final result = await smartCoachRepositoryImpl.saveMessage(
        conversationId,
        message,
      );
      expect((result), isA<Result<void>>());
      expect((result as SuccessResult).successResult, null);
      verify(
        mockSmartCoachRemoteDataSource.saveMessage(conversationId, message),
      ).called(1);
    });
    test("return FailedResult when data source failed", () async {
      const error = "error to save message";
      when(
        mockSmartCoachRemoteDataSource.saveMessage(conversationId, message),
      ).thenAnswer((_) async => FailedResult(error));
      final result = await smartCoachRepositoryImpl.saveMessage(
        conversationId,
        message,
      );
      expect((result), isA<Result<void>>());
      expect((result as FailedResult).errorMessage, error);
      verify(
        mockSmartCoachRemoteDataSource.saveMessage(conversationId, message),
      ).called(1);
    });
  });
  group("setConversationTitle", () {
    const conversationId = '123';
    const title = "test-title";
    test("return SuccessResult when data source success", () async {
      when(
        mockSmartCoachRemoteDataSource.setConversationTitle(
          conversationId,
          title,
        ),
      ).thenAnswer((_) async => SuccessResult(null));
      final result = await smartCoachRepositoryImpl.setConversationTitle(
        conversationId,
        title,
      );
      expect(result, isA<Result<void>>());
      expect((result as SuccessResult).successResult, null);
      verify(
        mockSmartCoachRemoteDataSource.setConversationTitle(
          conversationId,
          title,
        ),
      ).called(1);
    });
  });
  group('getSmartCoachReplyStream', () {
    final mockChatHistory = [
      MessageEntity(

        text: 'Hello, I need help with my workout',
        role: Sender.user,
        timestamp: DateTime.now(),
      ),
      MessageEntity(
        text: 'Sure, I can help with that!',
        role: Sender.model,
        timestamp: DateTime.now(),
      ),
    ];
    test('should return stream with text from valid candidate', () async {
      // Arrange
      final mockCandidate = Candidates(
        content: Content(
          parts: [TextPart( 'This is a smart coach response')],
        ),
      );
      final mockStream = Stream<Candidates>.value(mockCandidate);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl
          .getSmartCoachReplyStream(mockChatHistory);

      // Assert
      await expectLater(
        resultStream,
        emitsInOrder([
          'This is a smart coach response',
          emitsDone,
        ]),
      );
    });

    test('should return fallback when candidate is null', () async {
      // Arrange
      final mockStream = Stream<Candidates?>.value(null);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory);

      // Assert
      await expectLater(
        resultStream,
        emitsInOrder([
          Constants.promptFallback,
          emitsDone,
        ]),
      );
    });

    test('should return fallback when candidate content is null', () async {
      // Arrange
      final mockCandidate = Candidates(content: null);
      final mockStream = Stream<Candidates>.value(mockCandidate);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory);

      // Assert
      await expectLater(
        resultStream,
        emitsInOrder([
          Constants.promptFallback,
          emitsDone,
        ]),
      );
    });

    test('should concatenate multiple text parts', () async {
      // Arrange
      final mockCandidate = Candidates(
        content: Content(
          parts: [
            TextPart( 'First part '),
            TextPart( 'Second part '),
            TextPart( 'Third part'),
          ],
        ),
      );
      final mockStream = Stream<Candidates>.value(mockCandidate);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: Constants.gemeniModel,
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory);

      // Assert
      await expectLater(
        resultStream,
        emitsInOrder([
          'First part Second part Third part',
          emitsDone,
        ]),
      );
    });

    test('should trim the final response', () async {
      // Arrange
      final mockCandidate = Candidates(
        content: Content(
          parts: [TextPart( '  Response with spaces   ')],
        ),
      );
      final mockStream = Stream<Candidates>.value(mockCandidate);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory);

      // Assert
      await expectLater(
        resultStream,
        emitsInOrder([
          'Response with spaces',
          emitsDone,
        ]),
      );
    });

    test('should handle empty parts list', () async {
      // Arrange
      final mockCandidate = Candidates(
        content: Content(parts: []),
      );
      final mockStream = Stream<Candidates>.value(mockCandidate);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory);

      // Assert
      await expectLater(
        resultStream,
        emitsInOrder([
          '',
          emitsDone,
        ]),
      );
    });


    test('should rethrow GemeniErrorException from stream error', () async {
      // Arrange
      final geminiException = GemeniErrorException(message: 'Gemini API error');
      final mockStream = Stream<Candidates>.error(geminiException);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory);

      // Assert
      await expectLater(
        resultStream,
        emitsError(
          isA<GemeniErrorException>()
              .having((e) => e.message, 'message', 'Gemini API error'),
        ),
      );
    });
    //
    test('should swallow non-GemeniErrorException stream errors', () async {
      // Arrange
      final nonGeminiException = Exception('Network error');
      final mockStream = Stream<Candidates>.error(nonGeminiException);

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenAnswer((_) => mockStream);

      // Act
      final resultStream = smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory);

      // Assert - The error should be swallowed, so stream completes without error
      await expectLater(
        resultStream,
        emitsDone,
      );
    });
    //
    test('should wrap exceptions in GemeniErrorException', () async {
      // Arrange
      final exception = Exception('DataSource error');

      when(mockSmartCoachRemoteDataSource.getSmartCoachResponseStream(
        any,
        model: anyNamed('model'),
      )).thenThrow(exception);

      // Act & Assert
      expect(
            () => smartCoachRepositoryImpl.getSmartCoachReplyStream(mockChatHistory),
        throwsA(
          isA<GemeniErrorException>()
              .having((e) => e.message, 'message', ' Exception: DataSource error'),
        ),
      );
    });


  });

}
