
import 'package:injectable/injectable.dart';

import '../entity/message_entity.dart';
import '../repo/smart_coach_repo.dart';


@injectable

class GetSmartCoachResponseUseCase {

  GetSmartCoachResponseUseCase(this._repository);
  final SmartCoachRepository _repository;

  Stream<String> call(List<MessageEntity> chatHistory) {
    return _repository.getSmartCoachReplyStream(chatHistory);
  }
}