import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/enum/sender.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/domain/entity/message_entity.dart';
import 'package:fitness/features/smart_coach/domain/use_case/delete_conversion_use_case.dart';
import 'package:fitness/features/smart_coach/domain/use_case/get_connversation_summaries_use_case.dart';
import 'package:fitness/features/smart_coach/domain/use_case/get_message_use_case.dart';
import 'package:fitness/features/smart_coach/domain/use_case/get_smart_coach_use_case.dart';
import 'package:fitness/features/smart_coach/domain/use_case/save_message_use_case.dart';
import 'package:fitness/features/smart_coach/domain/use_case/set_conversion_title.dart';
import 'package:fitness/features/smart_coach/domain/use_case/start_new_conversation_use_case.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'smart_coach_cubit_test.mocks.dart';

@GenerateMocks([
  DeleteConversationUseCase,
  GetConversationSummariesUseCase,
  GetMessagesUseCase,
  SaveMessagesUseCase,
  SetConversationTitleUseCase,
  StartNewConversationUseCase,
  GetSmartCoachResponseUseCase
])
void main() {
  late SmartCoachCubit cubit;
  late MockStartNewConversationUseCase mockStartNewConversation;
  late MockSetConversationTitleUseCase mockSetTitle;
  late MockSaveMessagesUseCase mockSaveMessages;
  late MockGetMessagesUseCase mockGetMessages;
  late MockGetConversationSummariesUseCase mockGetSummaries;
  late MockDeleteConversationUseCase mockDeleteConversation;
  late MockGetSmartCoachResponseUseCase mockGetResponse;

  const String testConversationId = '123';

  setUp(() {
    provideDummy<Result<String>>(FailedResult("dummy"));
    provideDummy<Result<void>>(FailedResult("dummy"));
    provideDummy<Result<List<MessageEntity>>>(FailedResult("errorMessage"));
    provideDummy<Result<List<Map<String,dynamic>>>>
      (FailedResult(""));

    mockStartNewConversation = MockStartNewConversationUseCase();
    mockSetTitle = MockSetConversationTitleUseCase();
    mockSaveMessages = MockSaveMessagesUseCase();
    mockGetMessages = MockGetMessagesUseCase();
    mockGetSummaries = MockGetConversationSummariesUseCase();
    mockDeleteConversation = MockDeleteConversationUseCase();
    mockGetResponse = MockGetSmartCoachResponseUseCase();

    cubit = SmartCoachCubit(
      mockGetResponse,
      mockSetTitle,
      mockStartNewConversation,
      mockSaveMessages,
      mockGetMessages,
      mockGetSummaries,
      mockDeleteConversation,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  group("Smart Coach Cubit", () {
    blocTest<SmartCoachCubit, SmartCoachChatState>(
      "Emits [loading, success] when start new conversation succeeds",
      build: () {
        when(mockStartNewConversation.call())
            .thenAnswer((_) async => SuccessResult(testConversationId));
        return cubit;
      },
      act: (cubit) => cubit.startNewConversation(),
wait: const Duration(seconds: 3),
      expect: () => [
        const SmartCoachChatState(stateStatus: StateStatus.loading()),
        const SmartCoachChatState(
          stateStatus: StateStatus.success(testConversationId),
        ),
      ],
      verify: (_) => verify(mockStartNewConversation.call()).called(1),
    );

    blocTest<SmartCoachCubit, SmartCoachChatState>(
      "emits [loading, failure] when start new conversation fails",
      build: () {
        when(mockStartNewConversation.call())
            .thenAnswer((_) async => FailedResult("error"));
        return cubit;
      },
      act: (cubit) => cubit.startNewConversation(),
      wait: const Duration(seconds: 3),
      expect: () => [
        const SmartCoachChatState(stateStatus: StateStatus.loading()),
        const SmartCoachChatState(
          stateStatus: StateStatus.failure(ResponseException(message: "error"))
        ),
      ],
      verify: (_) => verify(mockStartNewConversation.call()).called(1),
    );
  });
  group("loadConversation()", () {
    blocTest<SmartCoachCubit, SmartCoachChatState>(
      "emits updated state with provided messages",
      build: () => cubit,
      act: (cubit) {
        final messages = [
          const MessageEntity(
            role: Sender.user,
            text: "Hello",
          ),
          const MessageEntity(
            role: Sender.model,
            text: "Hi there!",
          ),
        ];

        cubit.loadConversation(testConversationId, messages);
      },
      expect: () => [
        cubit.state.copyWith(
          messages: [
            const MessageEntity(
              role: Sender.user,
              text: "Hello",
            ),
            const MessageEntity(
              role: Sender.model,
              text: "Hi there!",
            ),
          ],
        ),
      ],
    );
  });
group("fetchConversationSummaries", (){
  final mockData = [
    {'id': '123', 'startedAt': DateTime.now(), 'text': 'Hello there'},
  ];
  const error="failed to load data";
  blocTest<SmartCoachCubit,SmartCoachChatState>
    ("emit [ loading,success] when GetMessagesUseCase success",
      build: (){
      when(mockGetSummaries.call()).thenAnswer((_)async
      =>SuccessResult(mockData));
    return cubit;
  },act: (bloc)=>bloc.fetchConversationSummaries(),
  expect: ()=>[
    const SmartCoachChatState(
      stateStatus: StateStatus.loading()
    ),
     SmartCoachChatState(
        stateStatus: StateStatus.success(mockData)
    ),

  ],verify: (_)=>verify(mockGetSummaries.call()).called(1)
  );
  blocTest("emit [ loading,failure] when  GetMessagesUseCase failure",
      build: (){
        when(mockGetSummaries.call()).thenAnswer((_)async
        =>FailedResult(error));
        return cubit;
      },act: (bloc)=>bloc.fetchConversationSummaries(),
  expect: ()=>[
    const SmartCoachChatState(
        stateStatus: StateStatus.loading()
    ),
    const SmartCoachChatState(
      errorMessage: error,
        stateStatus: StateStatus.failure(ResponseException(message: error))
    ),
  ],verify: (_)=>verify(mockGetSummaries.call()).called(1)
  );
});
group("fetchMessagesByConversationId", (){
  final messages = [
    const MessageEntity(role: Sender.user, text: "test text"),
    const MessageEntity(role: Sender.model, text: "fitness text"),
  ];
  const error="some thing went wrong";
  blocTest<SmartCoachCubit,SmartCoachChatState>("emit [loading,success] when fetchMessagesByConversationId use case success",
      build: (){
    when(mockGetMessages.call(testConversationId)).
    thenAnswer((_)async=>SuccessResult(messages));
    return cubit;
      },act: (bloc)=>bloc.fetchMessagesByConversationId(testConversationId),
  expect: ()=>[
    const SmartCoachChatState(
      stateStatus: StateStatus.loading()
    ),
    SmartCoachChatState(
      messages: messages,
        stateStatus: StateStatus.success(messages)
    ),
  ],verify: (_)=>verify(mockGetMessages.call(testConversationId)).called(1)
  );
blocTest<SmartCoachCubit,SmartCoachChatState>
  ("emit [loading,failure] when fetchMessagesByConversationId use case failed",
    build: (){
    when(mockGetMessages.call(testConversationId)).thenAnswer((_)
    async=>FailedResult(error));
    return cubit;
    },act: (bloc)=>bloc.fetchMessagesByConversationId(testConversationId),
verify: (_)=>verify(mockGetMessages.call(testConversationId)).called(1)
);
});
  group("delete Conversation", (){

    const error="some thing went wrong";
    final mockData = [
      {'id': '123', 'startedAt': DateTime.now(),
        'text': 'Hello there'},
    ];
    // blocTest<SmartCoachCubit, SmartCoachChatState>(
    //   "emit [success] when delete conversation succeeds",
    //   build: () {
    //     when(mockDeleteConversation.call(testConversationId))
    //         .thenAnswer((_) async => SuccessResult(null));
    //
    //     when(mockGetSummaries.call())
    //         .thenAnswer((_) async => SuccessResult([]));
    //
    //     return cubit;
    //   },
    //   act: (bloc) => bloc.deleteConversation(testConversationId),
    //   expect: () => [
    //     const SmartCoachChatState(
    //       stateStatus: StateStatus.success({}),
    //     ),
    //   ],
    //   skip: 2,
    //
    //
    //   verify: (_) {
    //     verify(mockDeleteConversation.call(testConversationId)).called(1);
    //     verify(mockGetSummaries.call()).called(1);
    //   },
    // );
    blocTest<SmartCoachCubit, SmartCoachChatState>(
      "emit success only (skip loading) when delete succeeds",
      build: () {
        when(mockDeleteConversation.call(testConversationId))
            .thenAnswer((_) async => SuccessResult(null));

        when(mockGetSummaries.call())
            .thenAnswer((_) async => SuccessResult([]));

        return cubit;
      },

      act: (bloc) => bloc.deleteConversation(testConversationId),

      skip: 2,

      expect: () => [
        const SmartCoachChatState(
          stateStatus: StateStatus.success([]),
        ),
      ],

      verify: (_) {
        verify(mockDeleteConversation.call(testConversationId)).called(1);
        verify(mockGetSummaries.call()).called(1);
      },
    );


    blocTest<SmartCoachCubit, SmartCoachChatState>(
      "emit [failure] when deleteConversation use case fails",
      build: () {
        when(mockDeleteConversation.call(testConversationId))
            .thenAnswer((_) async => FailedResult(error));

        return cubit;
      },
      act: (cubit) => cubit.deleteConversation(testConversationId),
      expect: () => [
        const SmartCoachChatState(
          isLoading: false,
          errorMessage: error,
          stateStatus:
          StateStatus.failure(ResponseException(message: error)),
        ),
      ],
      verify: (_) {
        verify(mockDeleteConversation.call(testConversationId)).called(1);
      },
    );

  });
  group("Send Message", () {
    const testPrompt = "fitness";


  });



}
