

import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../entity/message_entity.dart';
import '../repo/smart_coach_repo.dart';


@injectable

class GetMessagesUseCase {

  GetMessagesUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<Result<List<MessageEntity>>> call(String conversationId) {
    return _repository.fetchMessages(conversationId);
  }
}