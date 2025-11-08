import 'package:fitness/core/result/result.dart';

abstract interface class LogoutRepo {
  Future<Result<void>> logout();
}