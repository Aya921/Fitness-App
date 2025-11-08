

import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../entity/message_entity.dart';
import '../repo/smart_coach_repo.dart';


@injectable

class SaveMessagesUseCase {

  SaveMessagesUseCase(this._repository);
  final SmartCoachRepository _repository;

  Future<Result<void>> call(String conversationId, MessageEntity message) {
    return _repository.saveMessage(conversationId, message);
  }
}