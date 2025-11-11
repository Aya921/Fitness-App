import 'package:fitness/core/result/result.dart';

import '../../entities/chage_pass/change_pass_request.dart';

abstract interface class ChangePassRepo {
  Future<Result<void>> changePassword({
    required ChangePassRequest changePassRequest});
}
