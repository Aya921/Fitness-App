import 'package:fitness/core/enum/sender.dart';
import 'package:fitness/features/smart_coach/domain/entity/message_entity.dart';
import 'package:fitness/features/smart_coach/domain/use_case/get_smart_coach_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


// Generate mocks
import 'get_connversation_summaries_use_case_test.mocks.dart';


void main() {
  late MockSmartCoachRepository mockRepository;
  late GetSmartCoachResponseUseCase useCase;

  setUp(() {
    mockRepository = MockSmartCoachRepository();
    useCase = GetSmartCoachResponseUseCase(mockRepository);
  });

  group('GetSmartCoachResponseUseCase', () {
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

    final mockResponseStream = Stream<String>.fromIterable([
      'Let me analyze',
      'Let me analyze your workout',
      'Let me analyze your workout and provide suggestions',
    ]);

    test('should call repository with correct parameters', () async {
      when(mockRepository.getSmartCoachReplyStream(any))
          .thenAnswer((_) => const Stream<String>.empty());

      final result = useCase.call(mockChatHistory);

      verify(mockRepository.getSmartCoachReplyStream(mockChatHistory)).called(
          1);
      expect(result, isA<Stream<String>>());
    });

    test('should return stream from repository', () async {
      when(mockRepository.getSmartCoachReplyStream(any))
          .thenAnswer((_) => mockResponseStream);

      final result = useCase.call(mockChatHistory);

      await expectLater(
        result,
        emitsInOrder([
          'Let me analyze',
          'Let me analyze your workout',
          'Let me analyze your workout and provide suggestions',
          emitsDone,
        ]),
      );
    });

    test('should handle empty chat history', () async {
      final emptyChatHistory = <MessageEntity>[];
      final emptyStream = Stream<String>.value('Hello! How can I help you?');

      when(mockRepository.getSmartCoachReplyStream(emptyChatHistory))
          .thenAnswer((_) => emptyStream);

      final result = useCase.call(emptyChatHistory);

      await expectLater(
        result,
        emitsInOrder([
          'Hello! How can I help you?',
          emitsDone,
        ]),
      );

      verify(mockRepository.getSmartCoachReplyStream(emptyChatHistory)).called(
          1);
    });
  });

}