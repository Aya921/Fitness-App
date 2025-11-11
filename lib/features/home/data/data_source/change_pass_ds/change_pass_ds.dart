import 'package:fitness/core/result/result.dart';

import '../../../domain/entities/chage_pass/change_pass_request.dart';

abstract interface class ChangePassDs {
   Future<Result<void>> changePassword({
    required ChangePassRequest changePassRequest});
}