import 'dart:convert';

import 'package:fitness/features/home/data/data_source/json_content_data_source/json_content_data_source.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: JsonContentDataSource)
class JsonContentDataSourceImpl implements JsonContentDataSource{
  @override
  Future<List<dynamic>> loadJsonContent(String assetPath) async {
   try {
      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> data = json.decode(jsonString);
      
      final contentList = data.values.firstWhere(
        (value) => value is List,
        orElse: () => [],
      );
      
      return contentList as List;
    } catch (e) {
      throw Exception('Failed to load JSON content: $e');
    }
  }
  }

