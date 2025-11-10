import 'package:fitness/core/enum/sender.dart';
import 'package:fitness/features/smart_coach/domain/entity/message_entity.dart';
import 'package:fitness/features/smart_coach/domain/use_case/get_message_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/domain/repo/smart_coach_repo.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_connversation_summaries_use_case_test.mocks.dart';
@GenerateMocks([SmartCoachRepository])
void main() {
  late GetMessagesUseCase getMessagesUseCase;
  late MockSmartCoachRepository mockSmartCoachRepository;
  setUp((){
    mockSmartCoachRepository=MockSmartCoachRepository();
    getMessagesUseCase=GetMessagesUseCase(mockSmartCoachRepository);
    provideDummy<Result<List<MessageEntity>>>(FailedResult("dummy error fetch message "));

  });
  group("fetchMessages ", (){
    const conversationId = '123';

    test("return SuccessResult when data source success", ()async{

      final messages = [
        const MessageEntity(role: Sender.user, text: "test text"),
        const MessageEntity(role: Sender.model, text: "fitness text"),
      ];
      when(mockSmartCoachRepository.fetchMessages(conversationId)).thenAnswer((_)async=>
          SuccessResult(messages));
      final result=await getMessagesUseCase.call(conversationId);
      expect(result, isA<Result<List<MessageEntity>>>());
      expect((result as SuccessResult).successResult, messages);
      verify(mockSmartCoachRepository.fetchMessages(conversationId)).called(1);
    });
    test("return SuccessResult when data source failed", ()async{
      const  error="failed to fetch message";
      when(mockSmartCoachRepository.fetchMessages(conversationId)).thenAnswer((_)async=>
          FailedResult(error));
      final result=await getMessagesUseCase.call(conversationId);
      expect(result, isA<Result<List<MessageEntity>>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockSmartCoachRepository.fetchMessages(conversationId)).called(1);
    });

  });
}