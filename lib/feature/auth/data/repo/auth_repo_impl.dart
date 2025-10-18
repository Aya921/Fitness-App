import 'package:injectable/injectable.dart';

import '../../domain/repo/auth_repo.dart';
@Injectable(as: AuthRepo)
class AuthRepoImpl implements  AuthRepo{}