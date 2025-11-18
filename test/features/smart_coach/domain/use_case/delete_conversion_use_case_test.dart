import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/smart_coach/domain/use_case/delete_conversion_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_connversation_summaries_use_case_test.mocks.dart';

void main() {
  late DeleteConversationUseCase deleteConversationUseCase;
  late MockSmartCoachRepository mockSmartCoachRepository;
  setUp((){
    mockSmartCoachRepository=MockSmartCoachRepository();
    deleteConversationUseCase=DeleteConversationUseCase(mockSmartCoachRepository);
    provideDummy<Result<void>>(FailedResult("dummy error delete message "));

  });
  group("delete Message", () {
    const conversationId = '123';

    test("return SuccessResult when data source success", () async {
      when(
        mockSmartCoachRepository.deleteConversation(conversationId),
      ).thenAnswer((_) async => SuccessResult(null));
      final result = await deleteConversationUseCase.call(
        conversationId,
      );
      expect(result, isA<Result<void>>());
      expect((result as SuccessResult).successResult, null);
      verify(
        mockSmartCoachRepository.deleteConversation(conversationId),
      ).called(1);
    });
    test("return FailedResult when data source failed", () async {
      const error = "error in deleting message";
      when(
        mockSmartCoachRepository.deleteConversation(conversationId),
      ).thenAnswer((_) async => FailedResult(error));
      final result = await deleteConversationUseCase.call(
        conversationId,
      );
      expect(result, isA<Result<void>>());
      expect((result as FailedResult).errorMessage, error);
      verify(
        mockSmartCoachRepository.deleteConversation(conversationId),
      ).called(1);
    });
  });
}