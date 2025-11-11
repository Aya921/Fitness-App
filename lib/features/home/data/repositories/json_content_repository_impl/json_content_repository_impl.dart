import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/json_content_data_source/json_content_data_source.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:fitness/features/home/domain/repositories/json_content_repository/json_content_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: JsonContentRepository)
class JsonContentRepositoryImpl implements JsonContentRepository{
  final JsonContentDataSource _jsonContentDataSource;
  JsonContentRepositoryImpl(this._jsonContentDataSource);
 @override
  Future<Result<HelpContentEntity>> getHelpContent() {
    return _jsonContentDataSource.fetchHelpData();
  }
 @override
  Future<Result<PrivacyPolicyEntity>> getPrivacyPolicy() {
    return _jsonContentDataSource.fetchPrivacyPolicyData();
  }
  @override
  Future<Result<SecurityRolesEntity>> getSecurityRoles() {
    return _jsonContentDataSource.fetchSecurityRolesData();
  }
}