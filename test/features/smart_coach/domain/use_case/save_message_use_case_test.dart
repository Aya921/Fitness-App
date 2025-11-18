import 'package:fitness/core/enum/sender.dart';
import 'package:fitness/features/smart_coach/domain/entity/message_entity.dart';
import 'package:fitness/features/smart_coach/domain/use_case/save_message_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/core/result/result.dart';

import 'package:mockito/mockito.dart';

import 'get_connversation_summaries_use_case_test.mocks.dart';
void main() {
  late SaveMessagesUseCase saveMessagesUseCase;
  late MockSmartCoachRepository mockSmartCoachRepository;
  setUp((){
    mockSmartCoachRepository=MockSmartCoachRepository();
    saveMessagesUseCase=SaveMessagesUseCase(mockSmartCoachRepository);
    provideDummy<Result<void>>(FailedResult("dummy error fetch message "));

  });
  group("saveMessage", (){
    const conversationId = '123';
    const message=MessageEntity(role: Sender.model, text: "fitness test ");
    test("return SuccessResult when data source success", ()async{
      when(mockSmartCoachRepository.saveMessage(conversationId, message)).
      thenAnswer((_)async
      =>SuccessResult(null));
      final result=await saveMessagesUseCase.call(conversationId, message);
      expect((result), isA<Result<void>>());
      expect((result as SuccessResult).successResult, null);
      verify(mockSmartCoachRepository.saveMessage(conversationId, message)).called(1);
    });
    test("return FailedResult when data source failed", ()async{
      const error="error to save message";
      when(mockSmartCoachRepository.saveMessage(conversationId, message)).
      thenAnswer((_)async
      =>FailedResult(error));
      final result=await saveMessagesUseCase.call(conversationId, message);
      expect((result), isA<Result<void>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockSmartCoachRepository.saveMessage(conversationId, message)).called(1);
    });
  });
}