import 'dart:convert';

import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/api/models/json_content_model/help_content_model.dart';
import 'package:fitness/features/home/api/models/json_content_model/privacy_content_model.dart';
import 'package:fitness/features/home/api/models/json_content_model/security_roles_model.dart';
import 'package:fitness/features/home/data/data_source/json_content_data_source/json_content_data_source.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: JsonContentDataSource)
class JsonContentDataSourceImpl implements JsonContentDataSource{
   final AssetBundle _assetBundle;

  JsonContentDataSourceImpl(this._assetBundle);
  @override
 Future<Result<HelpContentEntity>> fetchHelpData() async {
    try {
      final String jsonString =
          await _assetBundle.loadString('assets/json_files/help.json');
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final model = HelpContentModel.fromJson(jsonData);
      return SuccessResult(model.toEntity());
    } catch (error) {
      return FailedResult(error.toString());
    }
  }

   @override
  Future<Result<PrivacyPolicyEntity>> fetchPrivacyPolicyData() async {
    try {
      final String jsonString =
          await _assetBundle.loadString('assets/json_files/privacy_and_security.json');
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final model = PrivacyPolicyModel.fromJson(jsonData);
      return SuccessResult(model.toEntity());
    } catch (error) {
      return FailedResult(error.toString());
    }
  }

  @override
  Future<Result<SecurityRolesEntity>> fetchSecurityRolesData() async {
    try {
      final String jsonString =
          await _assetBundle.loadString('assets/json_files/security_roles_config.json');
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final model = SecurityRolesModel.fromJson(jsonData);
      return SuccessResult(model.toEntity());
    } catch (error) {
      return FailedResult(error.toString());
    }
  }
  }

