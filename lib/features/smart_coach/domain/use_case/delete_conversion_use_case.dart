
import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../repo/smart_coach_repo.dart';



@injectable

class DeleteConversationUseCase {

  DeleteConversationUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<Result<void>> call(String conversationId) {
    return _repository.deleteConversation(conversationId);
  }
}