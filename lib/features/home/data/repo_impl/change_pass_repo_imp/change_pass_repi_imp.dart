import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/change_pass_ds/change_pass_ds.dart';
import 'package:fitness/features/home/domain/repo/change_pass_repo/change_pass_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/chage_pass/change_pass_request.dart';

@Injectable(as: ChangePassRepo)
class ChangePassRepiImp implements ChangePassRepo {
  final ChangePassDs _changePassDs;
  const ChangePassRepiImp(this._changePassDs);

  @override
  Future<Result<void>> changePassword({required ChangePassRequest changePassRequest})async {
   return await _changePassDs.changePassword(changePassRequest: changePassRequest);
  }


}
