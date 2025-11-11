import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';

abstract class JsonContentDataSource {
   Future<Result<HelpContentEntity>> fetchHelpData();
    Future<Result<PrivacyPolicyEntity>> fetchPrivacyPolicyData();
    Future<Result<SecurityRolesEntity>> fetchSecurityRolesData();

}