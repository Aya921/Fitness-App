import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../repo/smart_coach_repo.dart';


@injectable

class StartNewConversationUseCase {

  StartNewConversationUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<Result<String>>  call() {
    return _repository.startNewConversation();
  }
}