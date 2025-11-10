import 'package:fitness/features/home/data/data_source/json_content_data_source/json_content_data_source.dart';
import 'package:fitness/features/home/domain/repositories/json_content_repository/json_content_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: JsonContentRepository)
class JsonContentRepositoryImpl implements JsonContentRepository{
  final JsonContentDataSource _jsonContentDataSource;
  JsonContentRepositoryImpl(this._jsonContentDataSource);
  @override
  Future<List<dynamic>> fetchJsonContent(String assetPath) {
    return _jsonContentDataSource.loadJsonContent(assetPath);
  }

}