import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/domain/repo/smart_coach_repo.dart';
import 'package:fitness/features/smart_coach/domain/use_case/get_connversation_summaries_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_connversation_summaries_use_case_test.mocks.dart';
@GenerateMocks([SmartCoachRepository])
void main() {
  late GetConversationSummariesUseCase getConversationSummariesUseCase;
late MockSmartCoachRepository mockSmartCoachRepository;
setUp((){
  mockSmartCoachRepository=MockSmartCoachRepository();
  getConversationSummariesUseCase=GetConversationSummariesUseCase(mockSmartCoachRepository);
  provideDummy<Result<List<Map<String,dynamic>>>>(FailedResult("dummy error fetchConversationSummaries "));

});
  group("fetchConversationSummaries", (){
    test("return SuccessResult when data source success", ()async{
      final mockData = [
        {'id': '123', 'startedAt': DateTime.now(), 'text': 'Hello there'},
      ];
      when(mockSmartCoachRepository.fetchConversationSummaries()).thenAnswer((_)async=>
          SuccessResult(mockData));
      final result=await getConversationSummariesUseCase.call();
      expect(result, isA<Result<List<Map<String,dynamic>>>>());
      expect((result as SuccessResult).successResult, mockData);
      verify(mockSmartCoachRepository.fetchConversationSummaries()).called(1);
    });
    test("return SuccessResult when data source failed", ()async{
      const  error="failed to load chats";
      when(mockSmartCoachRepository.fetchConversationSummaries()).thenAnswer((_)async=>
          FailedResult(error));
      final result=await getConversationSummariesUseCase.call();
      expect(result, isA<Result<List<Map<String,dynamic>>>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockSmartCoachRepository.fetchConversationSummaries()).called(1);
    });

  });

}