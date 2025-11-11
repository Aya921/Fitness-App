import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repo/json_content_repository/json_content_repository.dart';
@injectable
class JsonContentUseCase {
  final JsonContentRepository _jsonContentRepository;

  JsonContentUseCase({required JsonContentRepository jsonContentRepository}) : _jsonContentRepository = jsonContentRepository;
   
    Future<Result<HelpContentEntity>> callHelp() {
    return _jsonContentRepository.getHelpContent();
  }

  Future<Result<PrivacyPolicyEntity>> callPrivacy() {
    return _jsonContentRepository.getPrivacyPolicy();
  }

  Future<Result<SecurityRolesEntity>> callSecurity() {
    return _jsonContentRepository.getSecurityRoles();
  }
}