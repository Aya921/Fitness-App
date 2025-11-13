

import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../repo/smart_coach_repo.dart';


@injectable

class SetConversationTitleUseCase {

  SetConversationTitleUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<Result<void>>call(String conversationId, String title) {
    return _repository.setConversationTitle(conversationId, title);
  }
}