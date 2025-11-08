
import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../repo/smart_coach_repo.dart';


@injectable

class GetConversationSummariesUseCase {

  GetConversationSummariesUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<Result<List<Map<String, dynamic>>>>  call() {
    return _repository.fetchConversationSummaries();
  }
}