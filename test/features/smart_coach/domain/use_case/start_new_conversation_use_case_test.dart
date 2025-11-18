import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/domain/use_case/start_new_conversation_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_connversation_summaries_use_case_test.mocks.dart';
void main() {
  late StartNewConversationUseCase startNewConversationUseCase;
  late MockSmartCoachRepository mockSmartCoachRepository;
  setUp((){
    mockSmartCoachRepository=MockSmartCoachRepository();
    startNewConversationUseCase=StartNewConversationUseCase(mockSmartCoachRepository);
    provideDummy<Result<String>>(FailedResult("dummy error fetchConversationSummaries "));

  });
  group("startNewConversation", (){
    const convId="test";
    test("return SuccessResult when data source success", ()async{

      when(mockSmartCoachRepository.startNewConversation()).thenAnswer((_)
      async=>SuccessResult(convId));
      final result=await startNewConversationUseCase.call();
      expect(result, isA<Result<String>>());
      expect((result as SuccessResult).successResult, convId);
      verify(mockSmartCoachRepository.startNewConversation()).called(1);
    });
    test("return FailedResult when data source failed", ()async{
      const error="error to set conversation title ";
      when(mockSmartCoachRepository.startNewConversation()).thenAnswer((_)
      async=>FailedResult(error));
      final result=await startNewConversationUseCase.call();
      expect(result, isA<Result<String>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockSmartCoachRepository.startNewConversation()).called(1);
    });
  });

}